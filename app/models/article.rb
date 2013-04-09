require 'sanitize/sanitize.rb'
class Article < ActiveRecord::Base
  attr_accessible :description, :full_text, :title,
                  :user_id, :articles_categories_attributes

  has_many :articles_categories
  has_many :categories, through: :articles_categories
  has_many :comments, as: :commentable
  belongs_to :user

  before_create :sanitize_input

  paginates_per 25

  accepts_nested_attributes_for :articles_categories

  private

  def sanitize_input
    self.full_text = TunedSanitize::for_(self.full_text)
  end

  def self.sort_by(sort_type_params)
    if sort_type_params == 'Author'
      sort_type = 'user_id'
    elsif sort_type_params == 'Date'
      sort_type = 'created_at'
    else
      sort_type = 'created_at'
    end

    order("articles.#{sort_type} ASC")
  end
end
