FactoryGirl.define do
  factory :order do
    user
    total_in_cents { rand(10000 +  1) }
  end
end
