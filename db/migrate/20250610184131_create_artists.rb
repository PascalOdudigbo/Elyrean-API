class CreateArtists < ActiveRecord::Migration[8.0]
 def change
    create_table :artists, id: false do |t|
      # Define user_id as the primary key.
      # The foreign key constraint will be added separately.
      t.bigint :user_id, null: false, primary_key: true

      t.string :name, null: false, index: { unique: true }
      t.text :bio
      t.string :image
      t.string :image_public_id

      t.timestamps
    end

    # Explicitly add the foreign key constraint after the table is created.
    # This correctly links artists.user_id to users.id
    add_foreign_key :artists, :users, column: :user_id
  end
end