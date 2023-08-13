FactoryBot.define do

  factory :comment do
    association :ticket
    text { 'Commentのテスト投稿' }
  end
end
