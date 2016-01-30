class Product < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :price_in_cents, numericality: { only_integer: true }
end
