FactoryBot.define do
  factory :jwt_blacklist do
    jti { "MyString" }
    exp { "2019-12-29 19:49:34" }
  end
end
