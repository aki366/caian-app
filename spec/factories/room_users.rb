FactoryBot.define do

  factory :room_user, class: RoomUser do
    association :room
  end
end
