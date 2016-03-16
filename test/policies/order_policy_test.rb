require 'test_helper'

class OrderPolicyTest < ActiveSupport::TestCase
  setup do
    @current_user = create(:user)
  end

  test "Scope#resolve" do
    3.times { |n| create(:order, user: @current_user) }
    expected = Order.where(user: @current_user)
    assert_equal expected, Pundit.policy_scope(@current_user, Order)
  end

  test "#permitted_attributes" do
    attributes = [product_ids: []]
    assert_equal attributes, OrderPolicy.new(@current_user, Order.new).permitted_attributes
  end

  test "show? when wrong user" do
    record = OpenStruct.new(id: 2)
    refute OrderPolicy.new(@current_user, record).show?
  end

  test "show? when correct user" do
    record = OpenStruct.new(user_id: @current_user.id)
    assert OrderPolicy.new(@current_user, record).show?
  end

  test "create?" do
    assert OrderPolicy.new(@current_user, Order.new).create?
  end
end
