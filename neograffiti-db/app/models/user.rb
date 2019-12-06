class User < ApplicationRecord
  has_secure_password
  has_many :posts
  has_many :comments
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates :full_name, presence: true
  validates :password, presence: true, length: { minimum: 6 }, :if=>:password
end
