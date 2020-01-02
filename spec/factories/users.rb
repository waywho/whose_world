FactoryBot.define do
  factory :user do
    name { "MyString" }
    sequence(:email) {|n| "dummyEmail#{n}@gmail.com" }
    password { "MyString" }
    password_confirmation { "MyString" }
    admin { false }
  end
end
