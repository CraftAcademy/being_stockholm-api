FactoryBot.define do
  factory :post do
    caption { "MyString" }
    status { 1 }
    category { 1 }
    latitude { 53.06 }
    longitude { 18.03 }
    address {"MyString"}
    association :user
  end
end
