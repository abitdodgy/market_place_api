FactoryGirl.define do
  sequence(:email) { |n| "user_#{n}@example.com" }

  factory :user, aliases: [:owner] do
    name "Iben Batuta"
    email
    password "121212"
  end
end
