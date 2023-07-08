class RemoveUniqueIndexFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_index :users, column: :username, unique: true
  end
end
