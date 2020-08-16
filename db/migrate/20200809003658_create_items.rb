class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :price, null: false
      # t.references :brand_id, null: false,foreign_key: true
      # t.references :category_id, null: false, foreign_key: true
      # t.references :sizing_id, foreign_key: true
      # t.references :item_conditions_id, foreign_key: true
      # t.references :postage_pay_id, null: false, foreign_key: true
      # t.references :preparation_day_id, null: false, foreign_key: true
      # t.integer :prefecture
      # t.references :buyer_id, null: false, foreign_key: true
      # t.references :seller_id, null: false, foreign_key: true
      t.timestamps
    end
  end
end
