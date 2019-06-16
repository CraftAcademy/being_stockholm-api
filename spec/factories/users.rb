FactoryBot.define do
  factory :user do
    email { "stefano@migrado.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end