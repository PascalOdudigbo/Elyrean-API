class CreateArtists < ActiveRecord::Migration[8.0]
  def change
    create_table :artists, id: false do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false, unique: true
      t.text :bio
      t.string :image
      t.string :image_public_id

      t.timestamps
    end
    # Set user_id as the primary key
    execute "ALTER TABLE artists ADD PRIMARY KEY (user_id);"
  end
end
