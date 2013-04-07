class Video < ActiveRecord::Base
  attr_accessible :youtube_url

  def parse_youtube
    regex = /^(?:http:\/\/)?(?:www\.)?\w*\.\w*\/(?:watch\?v=)?((?:p\/)?[\w\-]+)/
    self.youtube_url.match(regex) ? self.youtube_url.match(regex)[1] : nil
  end
end
