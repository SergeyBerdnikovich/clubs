class Video < ActiveRecord::Base
  attr_accessible :youtube_url, :description, :attachment

  has_many :categories_videos
  has_many :categories, through: :categories_videos
  belongs_to :user

  has_attached_file :attachment,
                    :url  => "/videos/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/videos/:id/:style/:basename.:extension",
                    :styles => { :medium => { :geometry => "640x480", :format => 'flv' },
                                 :thumb => { :geometry => "100x100#", :format => 'jpg', :time => 10 }
                    },
                    :processors => [:ffmpeg]

  extend FriendlyId
  friendly_id :categories_and_title, use: :slugged

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

  private

  def categories_and_title
    "#{categories.map {|cat| cat.name.to_slug.normalize! :transliterations => :russian}.join(' ')} - #{description.to_slug.normalize! :transliterations => :russian}"
  end

  def normalize_friendly_id(text)
    text.to_slug.normalize! :transliterations => :russian
  end
end
