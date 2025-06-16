class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description
      t.decimal :base_price, null: false
      t.references :category, null: false, foreign_key: true
      t.references :collection, null: false, foreign_key: true
      t.references :artist, null: false, foreign_key: {to_table: :users}
      t.boolean :active, default: true, null: false

      t.timestamps
    end
  end
end
