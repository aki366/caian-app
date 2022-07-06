FactoryBot.define do

  factory :room do
    trait :with_users do
      after(:create) do |room|
        room.room_users << FactoryBot.create(:room_user, :with_users)
        room.room_users << FactoryBot.create(:room_user, :with_users)
      end
    end
  end
end
