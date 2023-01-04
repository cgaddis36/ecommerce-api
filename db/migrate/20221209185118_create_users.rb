class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.integer :role, default: 0
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :token
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :phone

      t.timestamps
    end
  end
end
