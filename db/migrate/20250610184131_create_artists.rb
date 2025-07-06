class CreateArtists < ActiveRecord::Migration[8.0]
  def change
    create_table :artists, id: false do |t|
      # Define user_id as the primary key and foreign key
      t.bigint :user_id, null: false, primary_key: true, foreign_key: { to_table: :users }
      t.string :name, null: false, unique: true
      t.text :bio
      t.string :image
      t.string :image_public_id

      t.timestamps
    end
  end
end