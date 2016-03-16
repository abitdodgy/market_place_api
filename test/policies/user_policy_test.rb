require 'test_helper'

class UserPolicyTest < ActiveSupport::TestCase
  setup do
    @current_user = OpenStruct.new(id: 1)
  end

  test "Scope#resolve" do
    assert_equal Pundit.policy_scope(@current_user, User).all, User.all
  end

  test "#permitted_attributes" do
    attributes = [:name, :email, :password]
    assert_equal attributes, UserPolicy.new(@current_user, User.new).permitted_attributes
  end

  test "#show?" do
    record = OpenStruct.new(id: 2)
    assert UserPolicy.new(@current_user, record).show?
  end

  test "#update? when same user" do
    assert UserPolicy.new(@current_user, @current_user).update?
  end

  test "#update? when wrong user" do
    record = OpenStruct.new(id: 2)
    refute UserPolicy.new(@current_user, record).update?
  end

  test "#destroy? when same user" do
    assert UserPolicy.new(@current_user, @current_user).destroy?
  end

  test "#destroy? when wrong user" do
    record = OpenStruct.new(id: 2)
    refute UserPolicy.new(@current_user, record).destroy?
  end
end
