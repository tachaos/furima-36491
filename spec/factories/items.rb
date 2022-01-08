FactoryBot.define do
  factory :item do
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
    name               {Faker::Name.name}
    description        {"説明"}
    price              {2000}
    category_id        {1}
    status_id          {1}
    delivery_charge_id {1}
    delivery_source_id {1}
    delivery_days_id   {1}
    association :user
  end
end
