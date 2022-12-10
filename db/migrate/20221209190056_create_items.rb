class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.integer :stock
      t.float :price
      t.float :discount
      t.string :images
      t.string :color
      t.string :material
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
