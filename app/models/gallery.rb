class Gallery < ActiveRecord::Base
  attr_accessible :image, :image_content_type, :image_file_name, :image_file_size, :description

  has_attached_file :image,
                    :styles => { :small => "50x50>",
                                 :for_gallery => "200x200>",
                                 :normal => "700x700>" },
                    :url  => "/images/gallery/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/images/gallery/:id/:style/:basename.:extension"

  validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 2.megabytes
  validates_attachment_content_type :image,
                                    :content_type => ['image/jpg', 'image/jpeg', 'image/gif', 'image/png']
  has_many :categories_galleries
  has_many :categories, through: :categories_galleries
  has_many :comments, as: :commentable
  belongs_to :user

  paginates_per 6

  extend FriendlyId
  friendly_id :categories_and_title, use: :slugged

  def self.sort_by(sort_type_params)
    if sort_type_params == 'Name'
      sort_type = 'image_file_name'
    elsif sort_type_params == 'Size'
      sort_type = 'image_file_size'
    elsif sort_type_params == 'Date'
      sort_type = 'created_at'
    else
      sort_type = 'created_at'
    end

    order("galleries.#{sort_type} ASC")
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
