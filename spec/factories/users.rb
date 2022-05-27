# see: https://github.com/thoughtbot/factory_bot_rails
# see: https://github.com/faker-ruby/faker
FactoryBot.define do
  factory :user do
    # Fakerで毎回ランダムな値を生成して検証
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { "password" }
    profile { Faker::Hacker.say_something_smart }
    career { Faker::Job.position }
  end
end
