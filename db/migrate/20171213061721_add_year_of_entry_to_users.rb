class AddYearOfEntryToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :year_of_entry, :string
    add_column :users, :year_graduated, :string
  end
end
