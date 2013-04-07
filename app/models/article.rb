class Article < ActiveRecord::Base
  belongs_to :user
  attr_accessible :description, :full_text, :title
end
