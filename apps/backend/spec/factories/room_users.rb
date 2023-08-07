FactoryBot.define do
  factory :room_user, class: RoomUser do
    association :room

    trait :with_users do
      user_id { FactoryBot.create(:user).id }
    end
  end
end
