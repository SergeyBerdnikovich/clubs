require 'sanitize/sanitize.rb'
class Article < ActiveRecord::Base
  attr_accessible :description, :full_text, :title

  has_many :articles_categories
  has_many :categories, through: :articles_categories
  has_many :comments, as: :commentable
  belongs_to :user

  accepts_nested_attributes_for :categories,
                                :reject_if => :all_blank

  before_create :sanitize_input

  private

  def sanitize_input
    self.full_text = TunedSanitize::for_(self.full_text)
  end
end
