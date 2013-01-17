class AddIndexToUsers < ActiveRecord::Migration
  def change
    add_index :users, :age
    add_index :users, :gender
  end
end
