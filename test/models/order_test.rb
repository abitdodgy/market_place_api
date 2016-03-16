require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  should have_db_column(:id).of_type(:integer).with_options(primary:true, null: false)
  should have_db_column(:user_id).of_type(:integer).with_options(null: false)
  should have_db_column(:total_in_cents).of_type(:integer).with_options(null: false)
  should have_db_column(:status).of_type(:integer).with_options(null: false, default: 1)

  should have_db_index(:user_id)
  should have_db_index(:status)

  should belong_to(:user)

  should have_many(:placements)
  should have_many(:products).through(:placements)

  test "#dispatch! sets total and creates order" do
    products = 2.times.map { create(:product, price_in_cents: 5) }
    order = build(:order, products: products)

    assert_difference 'Order.count', 1 do
      order.dispatch!
      assert_equal 10, order.total_in_cents
    end
  end
end
