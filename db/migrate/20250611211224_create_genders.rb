class CreateGenders < ActiveRecord::Migration[8.0]
  def change
    create_table :genders do |t|
      t.string :name, null: false, unique: true

      t.timestamps
    end
  end
end
