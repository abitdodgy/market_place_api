class Product < ActiveRecord::Base
  belongs_to :owner, class_name: User, foreign_key: :user_id, inverse_of: :products

  validates :title, presence: true
  validates :price_in_cents, numericality: { only_integer: true }
end
