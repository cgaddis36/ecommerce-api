class CreateItemSizeColors < ActiveRecord::Migration[7.0]
  def change
    create_table :item_size_colors do |t|
      t.references :item, null: false, foreign_key: true
      t.references :size, null: false, foreign_key: true
      t.references :color, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
