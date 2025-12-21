class AddUniqueIndexToCategories < ActiveRecord::Migration[8.0]
  def change
    # Remove the old unique index on name
    remove_index :categories, :name

    # Add composite unique index on name + gender
    add_index :categories, [:name, :gender_id], unique: true
  end
end
