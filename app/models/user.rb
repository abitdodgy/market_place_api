class User < ActiveRecord::Base
  has_secure_password
  has_secure_token :auth_token

  has_many :products

  validates :name, presence: true
  validates :email, uniqueness: { case_sensitive: false }, length: { maximum: 60 }, email_format: true
end
