FactoryBot.define do

  factory :comment do
    association :post
    text { 'Commentのテスト投稿' }
  end
end
