class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :shipping_zip_code
      t.float :estimated_shipping
      t.float :discount
      t.float :tax
      t.float :total

      t.timestamps
    end
  end
end
