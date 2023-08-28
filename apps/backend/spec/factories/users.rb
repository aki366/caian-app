FactoryBot.define do
  factory :user do
    # Fakerで毎回ランダムな値を生成
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { "password" }
    profile { Faker::Hacker.say_something_smart }
  end

  factory :guest, class: User do
    name { "ゲストユーザー" }
    email { "guest@example.com" }
    password { "password" }
  end
end
