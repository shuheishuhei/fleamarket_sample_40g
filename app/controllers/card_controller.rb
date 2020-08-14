class CardController < ApplicationController

  require "payjp"

  def new
    card = Card.where(user_id: current_user.id)
    redirect_to action: "show" if card.exists?
  end

  def pay
    #payjp秘密鍵（テスト）
    Payjp.api_key = ENV 'sk_test_1e420a5429c5622cf700fdfd'
    if params['payjp-token'].blank?
      redirect_to action: "new"

    else
      #顧客を生成・取得
      customer = Payjp::Customer.create(
        card: params['payjp-token'],
        metadata: {user_id: curent_user.id}
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "show"
      else
        redirect_to action: "pay"
      end
    end
  end

  def delete
    card = Card.where(user_id: current_user.id).first
    if card.blank?
    else
      #retrieve = 検索して取り出す
      Payjp.api_key = ENV 'sk_test_1e420a5429c5622cf700fdfd'
      customer = Payjp::retrieve(card.customer_id)
      customer.delete
      card.delete
    end
      redirect_to action: "new"    
  end

  def show
    card = Card.where(user_id: current_user.id).first
    if card.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = ENV 'sk_test_1e420a5429c5622cf700fdfd'
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end
end
