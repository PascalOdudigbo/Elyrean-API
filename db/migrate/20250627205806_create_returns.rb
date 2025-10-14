class CreateReturns < ActiveRecord::Migration[8.0]
  def change
    create_table :returns do |t|
      t.references :order, null: false, foreign_key: true
      t.text :reason
      t.decimal :total_amount_returned, precision: 10, scale: 2, null: false
      t.string :status, null: false, default: 'Pending'
      t.datetime :return_date # When the return was received
      
      t.timestamps
    end
  end
end
