FactoryGirl.define do
  factory :product do
    owner
    title "Incredible Product"
    price_in_cents { rand(10_000) }
    published false
  end
end
