class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :price, null: false
      t.string :brand
      t.integer :condition_id, null: false
      t.integer :prefecture_id, null: false
      t.integer :day_id, null: false
      t.integer :postage_id, null: false
      t.integer :way_id, null: false
      t.integer :status_id, null: false
      t.timestamps
    end
  end
end
