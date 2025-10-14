class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false, index: { unique: true }
      t.text :description
      t.references :gender, null: false, foreign_key: true
      t.string :image
      t.string :image_public_id

      t.timestamps
    end
  end
end
