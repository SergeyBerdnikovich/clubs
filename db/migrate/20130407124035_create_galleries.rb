class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.attachment :image
      t.string :image_file_name
      t.integer :image_file_size
      t.string :image_content_type

      t.timestamps
    end
  end
end
