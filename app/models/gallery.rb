class Gallery < ActiveRecord::Base
  attr_accessible :image, :image_content_type, :image_file_name, :image_file_size
end
