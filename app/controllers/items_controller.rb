class ItemsController < ApplicationController
  # before_action :set_item, except: [:index, :new, :create]

  def index
    @items = Item.includes(:item_images).limit(5).order('created_at DESC')
  end

  def new
    @item = Item.new
    @item.item_images.build
    @category_parent_array = []
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent
    end
  end

  def get_category_children
    @category_children = Category.find_by(id: "#{params[:parent_id]}", ancestry: nil).children
  end
  
  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: '出品完了しました'
    else
      redirect_to new_item_path,
      alert: '失敗しました'
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path, notice: "削除しました"
    else
      render :new
    end
  end

  def destroy
    @item = Item.find(params[:id])
    if @item.destroy
      redirect_to item_path, notice: "削除しました"
    else
      render :new
    end
  end
  
  def show
    @item = Item.find(params[:id])
  end

  def buy
    # 商品ごとに複数枚写真を登録できるから全て
    # @images = @item.images.all
    if user_signed_in?
      if current_user.card.present?
        #.digではなくて.payjpにしとく。
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
  

  #商品購入確認（仮）
  def purchase_comfirmation
  end

  def pay    
    #とりあえずステイ
    # @images = @item.images.all
    if @item.deal == 1
      redirect_to item_path(@item.id), alert: "売り切れています。"
    else
      # 同時に2人が購入し、二重で購入処理がされることを防ぐための記述
      @item.with_lock do
        if current_user.card.present?
          # ログインユーザーがクレジットカード登録済みの場合の処理
          # ログインユーザーのクレジットカード情報を引っ張る
          @card = Card.find_by(user_id: current_user.id)

          Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_SECRET_KEY]
          #登録したカードでの、クレジットカード決済処理
          charge = Payjp::Charge.create(
          # itemの値段を引っ張ってきて決済金額(amount)に
          amount: @item.price,
          customer: Payjp::Customer.retrieve(@card.customer_id),
          currency: 'jpy'
          )
        else
          # ログインユーザーがクレジットカード登録されていない場合
          # APIの「Checkout」ライブラリによる決済処理をする
          Payjp::Charge.create(
          amount: @item.price,
          card: params['payjp-token'], # フォームを送信すると作成・送信されてくるトークン
          currency: 'jpy'
          )
        end
      end
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :introduction, :price, :prefecture_id, :condition_id, :postage_id, :way_id, :day_id, :category_id, :brand, :status_id,item_images_attributes: [:id, :item_id, :image, :_destroy]).merge(user_id: current_user.id)
  end
  
  def set_item
    @item = Item.find(params[:id])
  end

  # def set_item
  #   @item = Item.find(params[:id])
  # end

end
