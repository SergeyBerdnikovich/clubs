class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :articles
  has_many :galleries
  has_many :videos
  belongs_to :role

  before_create :assign_a_role

  def admin?
    self.role && self.role.title == 'admin'
  end

  private

  def assign_a_role
    if User.first
      self.role = Role.find_or_create_by_title('guest')
    else
      self.role = Role.find_or_create_by_title('admin')
    end
  end
end
