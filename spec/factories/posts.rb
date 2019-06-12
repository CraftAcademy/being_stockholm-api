FactoryBot.define do
  factory :post do
    caption { "MyString" }
    status { 1 }
    category { 1 }
    latitude { "9.99" }
    longitude { "9.99" }
  end
end
