class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :picture, PictureUploader


  has_one :image, as: :imageable
  has_many :memberships, foreign_key: :member_id
  has_many :groups, through: :memberships
  has_many :managed_groups, foreign_key: :jefe_id, class_name: "Group"
  has_many :posts, foreign_key: :creator_id
  has_many :snippets, foreign_key: :creator_id
  has_many :comments, foreign_key: :creator_id
end