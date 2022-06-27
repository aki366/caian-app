FactoryBot.define do

  factory :post do
    association :user
    content { 'Postのテスト投稿' }
  end
end
