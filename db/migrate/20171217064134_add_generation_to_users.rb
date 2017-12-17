class AddGenerationToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :generation, :string
  end
end
