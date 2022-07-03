FactoryBot.define do

  factory :room do
    association :user

    trait :with_users do
      after(:create) do |room|
        # sequenceを利用して、一つ一つ違うid(FK)のuserを作成
        user = FactoryBot.create(:user, :sequence)
        create_list(:user, 2, rooms: [room])
      end
    end
  end
end
