require "rails_helper"

RSpec.describe InvoiceItem, type: :model do

  before(:each) do
    @merchant_1 = Merchant.create!(name: "John")
    @merchant_2 = Merchant.create!(name: "Jacob")
    @merchant_3 = Merchant.create!(name: "Jingleheimer")
    @merchant_4 = Merchant.create!(name: "Schmidt")
    @merchant_5 = Merchant.create!(name: Faker::Name.first_name)
    @merchant_6 = Merchant.create!(name: Faker::Name.first_name)
    @merchant_7 = Merchant.create!(name: Faker::Name.first_name)
    @merchant_8 = Merchant.create!(name: Faker::Name.first_name)
    @merchant_9 = Merchant.create!(name: Faker::Name.first_name)
    @merchant_10 = Merchant.create!(name: Faker::Name.first_name)
  end

  describe "relationships" do
    it {should belong_to(:item)}
    it {should belong_to(:invoice)}
  end

  describe "::revenue" do
    it "can calculate the total amount of sales for a merchant" do
      hat = Item.create!(name: "Hat", description: "Makes the wearer look fancy", unit_price: 15000, merchant_id: @merchant_1.id)
      shirt = Item.create!(name: "Shirt", description: "Makes the wearer look kind", unit_price: 5000, merchant_id: @merchant_2.id)
      pants = Item.create!(name: "Pants", description: "Makes the wearer look strong", unit_price: 20000, merchant_id: @merchant_3.id)
      dress = Item.create!(name: "Dress", description: "Makes the wearer look delicate", unit_price: 25000, merchant_id: @merchant_4.id)
      socks = Item.create!(name: "Socks", description: "Makes the wearer smell nice", unit_price: 5000, merchant_id: @merchant_4.id)
      shoes = Item.create!(name: "Shoes", description: "Makes the wearer look successful", unit_price: 20000, merchant_id: @merchant_5.id)
      tie = Item.create!(name: "Tie", description: "Makes the wearer look old", unit_price: 10000, merchant_id: @merchant_5.id)
      watch = Item.create!(name: "Watch", description: "Makes the wearer look reliable", unit_price: 15000, merchant_id: @merchant_2.id)
      shorts = Item.create!(name: "Shorts", description: "Makes the wearer look relaxed", unit_price: 5000, merchant_id: @merchant_3.id)
      jacket = Item.create!(name: "Jacket", description: "Makes the wearer look stuffy", unit_price: 20000, merchant_id: @merchant_4.id)

      Item.all.each do |item|
        create(:invoice_item, item_id: item.id, quantity: 1)
      end

      InvoiceItem.all.each do |invoice_item|
        create(:invoice, id: invoice_item.item_id)
      end

      Invoice.all.each do |invoice|
        create(:transaction, result: "success", invoice_id: invoice.id)
      end

      merchant_top = Merchant.top_5_merchants.first
      merchant_last = Merchant.top_5_merchants.last

      expect(merchant_top.invoice_items.revenue).to eq(500)
      expect(merchant_last.invoice_items.revenue).to eq(150)
    end
  end
end
