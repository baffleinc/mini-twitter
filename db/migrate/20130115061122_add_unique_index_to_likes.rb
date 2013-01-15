class AddUniqueIndexToLikes < ActiveRecord::Migration
  def change
    add_index :likes, [:user_id, :micropost_id], unique: true
  end
end
