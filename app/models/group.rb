class Group < ActiveRecord::Base
  has_many :memberships
  has_many :members, through: :memberships, source: :user
  belongs_to :jefe, class_name: "User"
  has_many :posts
  has_many :snippets
  has_one :image, as: :imageable
end
