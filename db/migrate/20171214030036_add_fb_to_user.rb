class AddFbToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :fb, :string
    add_column :users, :ig, :string
    add_column :users, :twitter, :string
  end
end
