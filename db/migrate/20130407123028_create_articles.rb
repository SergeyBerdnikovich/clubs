class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :description
      t.text :full_text
      t.references :user

      t.timestamps
    end
    add_index :articles, :user_id
  end
end
