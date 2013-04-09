class CreateCategoriesVideos < ActiveRecord::Migration
  def change
    create_table :categories_videos do |t|
      t.references :category
      t.references :video

      t.timestamps
    end
    add_index :categories_videos, :category_id
    add_index :categories_videos, :video_id
  end
end
