FactoryBot.define do
  factory :seller_destination do
    postal_code { '123-4567' }
    delivery_source_id { 1 }
    city { '東京都' }
    block_number { '1-1' }
    building_name { '東京ハイツ' }
    phone_number { '00099993333' }
  end
end
