class CreateCarts < ActiveRecord::Migration[8.0]
  def change
    create_table :carts do |t|
      t.references :user, index: {unique: true}, null: false, foreign_key: true

      t.timestamps
    end
  end
end
