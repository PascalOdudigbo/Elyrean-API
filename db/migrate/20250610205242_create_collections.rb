class CreateCollections < ActiveRecord::Migration[8.0]
  def change
    create_table :collections do |t|
      t.string :name, null: false, uniqie: true
      t.text :description, null: false
      t.datetime :release_date
      t.boolean :active, null: false, default: true
      t.string :image
      t.string :image_public_id

      t.timestamps
    end
  end
end
