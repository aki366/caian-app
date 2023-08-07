FactoryBot.define do
  factory :ticket do
    association :user
    content { 'Ticketのテスト投稿' }
  end
end
