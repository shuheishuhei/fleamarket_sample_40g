class CardsController < ApplicationController
  require "payjp" #PAYJPとやり取りするために、payjpをロード

  def new
    
  end

  def create
    # credentials.yml.encに記載したAPI秘密鍵を呼び出す
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :sk_test_1e420a5429c5622cf700fdfd)

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
        redirect_to action: "#"
      end
    end
  end
end
