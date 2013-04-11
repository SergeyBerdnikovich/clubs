class Video < ActiveRecord::Base
  attr_accessible :youtube_url, :description

  has_many :categories_videos
  has_many :categories, through: :categories_videos
  belongs_to :user

  def parse_youtube
    regex = /^(?:http:\/\/)?(?:www\.)?\w*\.\w*\/(?:watch\?v=)?((?:p\/)?[\w\-]+)/
    self.youtube_url.match(regex) ? self.youtube_url.match(regex)[1] : nil
  end

  def self.sort_by(sort_type_params)
    if sort_type_params == 'Author'
      sort_type = 'user_id'
    elsif sort_type_params == 'Date'
      sort_type = 'created_at'
    else
      sort_type = 'created_at'
    end

    order("videos.#{sort_type} ASC")
  end

  def get_alt
    self.categories.map { |category| category.name }.join(' ') + ' ' + self.description
  end
end
