class CreateRefunds < ActiveRecord::Migration[8.0]
  def change
    create_table :refunds do |t|
      t.references :order, null: false, foreign_key: true
      t.references :return, foreign_key: true, null: true # A refund can be issued without a return

      t.decimal :amount, null: false, precision: 10, scale: 2
      t.string :currency, null: false
      t.string :status, null: false, default: 'Pending'
      t.string :refund_method, null: false
      t.string :stripe_refund_id # Can be null if not Stripe related

      t.references :approver, null: false, foreign_key: { to_table: :users } # User ID of approver
      t.datetime :approved_at

      t.timestamps
    end
  end
end
