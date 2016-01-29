require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_db_column(:name).of_type(:string).with_options(null: false)
  should have_db_column(:email).of_type(:string).with_options(null: false)
  should have_db_column(:password_digest).of_type(:string).with_options(null: false)
  should have_db_column(:password_reset_digest).of_type(:string).with_options(null: true)

  should have_db_index(:email).unique(true)
  should have_db_index(:password_reset_digest).unique(true)
  should have_db_index(:auth_token).unique(true)

  valid_emails = [
    'homer@simp.sp',
    '_BART_@simp.com',
    'lisa.simp@spring.field.com',
    'marg+simp@spring.field'
  ]
  should allow_value(*valid_emails).for(:email)

  invalid_emails = [
    'homer@simp',
    '_BART_@ simp.com',
    'lisa.simp.field.com',
    '@spring.com',
    'lisa@',
    'ba rt@simp.com',
    ' '
  ]
  should_not allow_value(*invalid_emails).for(:email)

  should validate_length_of(:email).is_at_most(60)

  test "validates uniqueness of email" do
    existing_user = create(:user, email: "exists@example.com")
    new_user = build(:user, email: "EXISTS@example.com")
    refute new_user.valid?
    assert_equal new_user.errors.messages, { email: ["has already been taken"] }
  end

  should validate_presence_of(:name)
  should validate_presence_of(:password)

  test "#auth_token is set before the user is created" do
    user = build(:user)
    assert_nil user.auth_token
    user.save!
    refute_nil user.auth_token
  end
end
