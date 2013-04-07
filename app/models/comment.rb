class Comment < ActiveRecord::Base
  belongs_to :user
  attr_accessible :body, :commentable_id, :commentable_type
end
