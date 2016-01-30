FactoryGirl.define do
  factory :product do
    user
    title "Incredible Product"
    price_in_cents 132
    published false
  end
end
