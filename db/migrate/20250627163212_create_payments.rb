class CreatePayments < ActiveRecord::Migration[8.0]
  def change
    create_table :payments do |t|
      t.references :order, index: {unique: true}, null: false, foreign_key: true
      t.string :stripe_payment_id, null: false, index: { unique: true }
      t.string :stripe_customer_id # Not necessarily unique to payment, can be null
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.string :currency, null: false
      t.string :status, null: false
      t.string :payment_method, null: false

      t.timestamps
    end
  end
end
