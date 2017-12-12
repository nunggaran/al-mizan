class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.string :slug
      t.integer :user_id
      t.string :image

      t.timestamps
    end
  end
end
