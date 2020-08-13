class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.integer :credit_number, null: false
      t.integer :expiration_year, null: false
      t.integer :expiration_month, null: false
      t.integer :security_code, null: false
      t.timestamps
    end
  end
end
