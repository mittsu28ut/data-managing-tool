class RemoveColumnsFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :password_salt, :string
    remove_column :users, :password_hash, :string
  end
end
