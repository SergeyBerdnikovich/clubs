require 'sanitize/sanitize.rb'
class StaticPage < ActiveRecord::Base
  attr_accessible :content, :title

  before_create :sanitize_input

  private

  def sanitize_input
    self.content = TunedSanitize::for_(self.content)
  end
end
