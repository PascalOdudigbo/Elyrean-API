class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: {on_delete: :cascade}
      t.decimal :total, precision: 10, scale: 2, null: false
      t.string :status, null: false, default: 'Pending'
      t.references :shipping_address, null: false, foreign_key: {to_table: :addresses}

      t.timestamps
    end
  end
end
