class User < ApplicationRecord
  has_many :reviews

  validates :username, :email, :password, presence: true
  validates :email, :username, uniqueness: { case_sensitive: false }
  
end
