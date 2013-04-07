class CreateCategoriesGalleries < ActiveRecord::Migration
  def change
    create_table :categories_galleries do |t|
      t.references :category
      t.references :gallery

      t.timestamps
    end
    add_index :categories_galleries, :category_id
    add_index :categories_galleries, :gallery_id
  end
end
