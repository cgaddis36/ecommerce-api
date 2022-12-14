class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :item_count
      t.float :total_weight
      t.string :shipping_first_name
      t.string :shipping_last_name
      t.string :shipping_address1
      t.string :shipping_address2
      t.string :shipping_city
      t.string :shipping_state
      t.string :shipping_zip_code
      t.float :shipping_price
      t.float :item_subtotal
      t.float :tax
      t.float :total
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
