class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :image
      t.string :uid
      t.string :password_digest
      t.timestamps null: false
    end
  end
end