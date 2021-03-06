require 'test_helper'

class ProductPolicyTest < ActiveSupport::TestCase
  setup do
    @current_user = OpenStruct.new(id: 1)
  end

  test "Scope#resolve" do
    3.times { |n| create(:product, published: n.even?) }
    expected = Product.where(published: true)
    assert_equal expected, Pundit.policy_scope(@current_user, Product)
  end

  test "#permitted_attributes" do
    attributes = [:title, :price_in_cents, :published]
    assert_equal attributes, ProductPolicy.new(@current_user, Product.new).permitted_attributes
  end

  test "#show?" do
    record = OpenStruct.new(id: 2)
    assert ProductPolicy.new(@current_user, record).show?
  end

  test "#create?" do
    record = OpenStruct.new(id: 2)
    assert ProductPolicy.new(@current_user, record).create?
  end

  test "#update? when owner" do
    record = OpenStruct.new(id: 2, user_id: 1)
    assert ProductPolicy.new(@current_user, record).update?
  end

  test "#update? when wrong user" do
    record = OpenStruct.new(id: 2, user_id: 2)
    refute ProductPolicy.new(@current_user, record).update?
  end

  test "#destroy? when owner" do
    record = OpenStruct.new(id: 2, user_id: 1)
    assert ProductPolicy.new(@current_user, record).destroy?
  end

  test "#destroy? when wrong user" do
    record = OpenStruct.new(id: 2, user_id: 2)
    refute ProductPolicy.new(@current_user, record).destroy?
  end
end
