FactoryBot.define do
  factory :merchant_md do
    name { Faker::Commerce.brand }
  end

  factory :customer_md do 
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end

  factory :item_md do 
      name { Faker::Commerce.product_name }
      description { Faker::Commerce.promotion_code(digits: 0) }
      unit_price { rand(2000..99999) }
  end

  factory :invoice_md do 
      status { rand(0..2) }
      created_at { Faker::Date.backward(days: 365) }
      updated_at { Faker::Date.between(from: created_at, to: Date.today) }
  end

  factory :transaction_md do
    association :invoice 
      credit_card_number { Faker::Business.credit_card_number }
      credit_card_expiration_date { Faker::Business.credit_card_expiry_date }
      result { ["failed", "success"].sample }
      created_at { Faker::Date.backward(days: 365) }
      updated_at { Faker::Date.between(from: created_at, to: Date.today) }
  end

  factory :invoice_item_md do 
      quantity {rand( 1..99) }
      unit_price { rand(5000..15000) }
      status { rand(0..2) }
      created_at { Faker::Date.backward(days: 365) }
      updated_at { Faker::Date.between(from: created_at, to: Date.today) }
  end

end