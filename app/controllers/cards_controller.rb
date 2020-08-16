class CardsController < ApplicationController
  require "payjp" 

  def new
    @card = Card.where(user_id: current_user.id)
    redirect_to card_path(current_user.id) if @card.exists?
  end

  def create
    Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_SECRET_KEY]
    # フラッシュメッセージ
    if params["payjp_token"].blank?
      redirect_to action: "new", alert: "クレジットカードを登録できませんでした。"
    else
    # 生成したトークンから、顧客情報と紐付け、PAY.JP管理サイトに登録
      customer = Payjp::Customer.create(
        email: current_user.email,
        card: params["payjp_token"],
        metadata: {user_id: current_user.id} 
      )
      # トークン化した情報をcardsテーブルに登録
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      # トークン作成とともにcardsテーブルに登録された場合、createビューが表示されるように条件分岐
      if @card.save
        #createビューを作成しない場合
      else
        redirect_to action: "create"
      end
    end
  end

  def show
    # ログイン中のユーザーのクレジットカード登録の有無を判断
    @card = Card.find_by(user_id: current_user.id)
    if @card.blank?
      # 未登録なら新規登録画面に
      redirect_to action: "new" 
    else
      Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_SECRET_KEY]
      # ログインユーザーのクレジットカード情報からPay.jpに登録されているカスタマー情報を引き出す
      customer = Payjp::Customer.retrieve(@card.customer_id)
      # カスタマー情報からカードの情報を引き出す
      @customer_card = customer.cards.retrieve(@card.card_id)

      ##カードのアイコン表示のための定義づけ
      @card_brand = @customer_card.brand
      case @card_brand
      when "Visa"
        @card_src = "visa.png"
      when "JCB"
        @card_src = "jcb.png"
      when "MasterCard"
        @card_src = "master.png"
      when "American Express"
        @card_src = "amex.png"
      when "Diners Club"
        @card_src = "diners.png"
      when "Discover"
        @card_src = "discover.png"
      end

      
      @exp_month = @customer_card.exp_month.to_s
      @exp_year = @customer_card.exp_year.to_s.slice(2,3)
    end
  end

  def destroy
    # ログイン中のユーザーのクレジットカード登録の有無を判断
    @card = Card.find_by(user_id: current_user.id)
    if @card.blank?
      # 未登録なら新規登録画面に
      redirect_to action: "new"
    else
      Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_SECRET_KEY]
      # ログインユーザーのクレジットカード情報からPay.jpに登録されているカスタマー情報を引き出す
      customer = Payjp::Customer.retrieve(@card.customer_id)
      # そのカスタマー情報を消す
      customer.delete
      @card.delete
      # 削除が完了しているか判断
      if @card.destroy
      # 削除完了していればdestroyのビューに移行
      
      else
        # 削除されなかった場合flashメッセージを表示させて、showのビューに移行
        redirect_to credit_card_path(current_user.id), alert: "削除できませんでした。"
      end
    end
  end





  # ↓決済機能（ちゃんとできるかな、、、）




  def buy
    # 購入する商品を引っ張る
    @item = Item.find(params[:item_id])
    # 商品ごとに複数枚写真を登録できるから全て
    @images = @item.images.all

    if user_signed_in?
      @user = current_user

      if @user.card.present?
        #.digではなくて.payjpにしとく
        Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_SECRET_KEY]
        # ログインユーザーのクレジットカード情報を引っ張る
        @card = Card.find_by(user_id: current_user.id)
        # ログインユーザーのクレジットカード情報からPay.jpに登録されているカスタマー情報を引き出す
        customer = Payjp::Customer.retrieve(@card.customer_id)
        # カスタマー情報からカードの情報を引き出す
        @customer_card = customer.cards.retrieve(@card.card_id)

        #帰ってきたブランドによって表示を分ける的な
        @card_brand = @customer_card.brand
        case @card_brand
        when "Visa"
          @card_src = "visa.gif"
        when "JCB"
          @card_src = "jcb.gif"
        when "MasterCard"
          @card_src = "master.png"
        when "American Express"
          @card_src = "amex.gif"
        when "Diners Club"
          @card_src = "diners.gif"
        when "Discover"
          @card_src = "discover.gif"
        end
        
        
        @exp_month = @customer_card.exp_month.to_s
        @exp_year = @customer_card.exp_year.to_s.slice(2,3)
      else
      end
    else
      # ログインしていなければ、商品の購入ができずに、ログイン画面に移動
      redirect_to user_session_path, alert: "ログインしてください"
    end
  end

  def pay

    @product = Product.find(params[:product_id])
    @images = @product.images.all

    
    # (二重決済wo防ぐ)
    if @product.purchase.present?
      redirect_to product_path(@product.id), alert: "売り切れています。"
    else
      # 同時に2人が同時に購入し、二重で購入処理がされることを防ぐための記述
      @product.with_lock do
        if current_user.credit_card.present?
          # ログインユーザーがクレジットカード登録済みの場合の処理
          # ログインユーザーのクレジットカード情報を引っ張る
          @card = Card.find_by(user_id: current_user.id)

          Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_SECRET_KEY]
          #登録したカードでの、クレジットカード決済処理
          charge = Payjp::Charge.create(
          # 商品(product)の値段を引っ張ってきて決済金額(amount)に入れる
          amount: @product.price,
          customer: Payjp::Customer.retrieve(@card.customer_id),
          currency: 'jpy'
          )
        else
          # ログインユーザーがクレジットカード登録されていない場合
          # APIの「Checkout」ライブラリによる決済処理をする
          Payjp::Charge.create(
          amount: @product.price,
          card: params['payjp-token'], # フォームを送信すると作成・送信されてくるトークン
          currency: 'jpy'
          )
        end
      #購入テーブルに登録処理
      @purchase = Purchase.create(buyer_id: current_user.id, product_id: params[:product_id])
      end
    end
  end
end
