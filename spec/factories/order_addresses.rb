FactoryBot.define do
  factory :order_address do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    city { '東京' }
    street_address { '東京' }
    building { '東京' }
    phone_number { '09001234567' }
    user_id         { FactoryBot.create(:user).id }
    item_id         { FactoryBot.create(:item).id }
    token           { 'tok_abcdefghijk00000000000000000' }
  end
end
