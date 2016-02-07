class Order < ActiveRecord::Base
  belongs_to :user

  has_many :placements
  has_many :products, through: :placements

  def dispatch!
    set_total!
    save
  end

private

  def set_total!
    self.total_in_cents = products.map(&:price_in_cents).reduce(:+)
    # self.total_in_cents = products.sum(:price_in_cents)
  end
end
