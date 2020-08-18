class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :price, null: false
      t.text :image, null: false
      
      # t.references :category, null: false, foreign_key: true
      # t.references :sizing, foreign_key: true
      # t.references :item_conditions, foreign_key: true
      # t.references :postage_pay, null: false, foreign_key: true
      # t.references :preparation_day, null: false, foreign_key: true
      t.integer :condition, null: false
      t.integer :prefecture, null: false
      t.integer :day, null: false
      t.integer :postage, null: false
      t.integer :way, null: false
      t.integer :status, null: false
      # t.references :buyer, null: false
      # t.references :seller, null: false
      
      # t.references :buyer, null: false, foreign_key: true
      # t.references :seller, null: false, foreign_key: true
      t.timestamps
    end
  end
end
