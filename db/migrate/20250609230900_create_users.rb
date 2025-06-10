class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :email, null: false, unique: true
      t.string :password_digest, null: false
      t.references :role, null: false, foreign_key: true
      t.boolean :active, default: false, null: false
      t.string :stripe_customer_id

      t.timestamps
    end
  end
end
