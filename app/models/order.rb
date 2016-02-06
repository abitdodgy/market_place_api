class Order < ActiveRecord::Base
  belongs_to :user

  has_many :placements
  has_many :products, through: :placements
end
