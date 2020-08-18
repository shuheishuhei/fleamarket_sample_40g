class AddBrandIdToItem < ActiveRecord::Migration[6.0]
  def change
    add_reference :items, :brand, null: false, foreign_key: true
  end
end
