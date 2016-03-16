require 'test_helper'

class PlacementTest < ActiveSupport::TestCase
  should have_db_column(:id).of_type(:integer).with_options(primary:true, null: false)
  should have_db_column(:order_id).of_type(:integer).with_options(null: false)
  should have_db_column(:product_id).of_type(:integer).with_options(null: false)

  should have_db_index(:order_id)
  should have_db_index(:product_id)

  should belong_to(:order)
  should belong_to(:product)
end
