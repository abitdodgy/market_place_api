require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  should have_db_column(:id).of_type(:integer).with_options(primary: true)
  should have_db_column(:title).of_type(:string).with_options(null: false)
  should have_db_column(:price_in_cents).of_type(:integer).with_options(null: false, default: 0)
  should have_db_column(:published).of_type(:boolean).with_options(null: false, default: false)
  should have_db_column(:created_at).of_type(:datetime).with_options(null: false)
  should have_db_column(:updated_at).of_type(:datetime).with_options(null: false)

  should have_db_index(:user_id)

  should belong_to(:owner).class_name("User").with_foreign_key(:user_id).inverse_of(:products)

  should validate_presence_of(:title)
  should validate_numericality_of(:price_in_cents).only_integer
end
