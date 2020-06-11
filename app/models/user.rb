class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable
  has_many :user_tags
  has_many :tags, through: :user_tags
  validates :email, uniqueness: { case_sensitive: false }
end
