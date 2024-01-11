require "rails_helper"

RSpec.describe "Merchant Dashboards", type: :feature do
  before(:each) do
    @merchant_1 = Merchant.create(name: "Chucky Cheese")
    @item_1 = @merchant_1.items.create(name: "Moldy Cheese", description: "ew", unit_price: 1199, merchant_id: @merchant_1.id)
    
    @customer_1 = Customer.create(first_name: "Steve", last_name: "Minecraft")
    @invoice_1 = @customer_1.invoices.create(customer: @customer_1, created_at: 5.days.ago, status: "in progress")
    InvoiceItem.create!(invoice: @invoice_1, item: @item_1, quantity: 5, unit_price: @item_1.unit_price, status: "packaged")
  end 

  it "15. Merchant Invoice Show Page" do 
    # When I visit my merchant's invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
    visit "merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"
    # Then I see information related to that invoice including:
    # - Invoice id
    expect(page).to have_content(@invoice_1.id)
    # - Invoice status
    expect(page).to have_content(@invoice_1.status)
    # - Invoice created_at date in the format "Monday, July 18, 2019"
    expect(page).to have_content(@invoice_1.created_at.strftime('%A, %B %d, %Y'))
    # - Customer first and last name
    expect(page).to have_content(@customer_1.first_name)
    expect(page).to have_content(@customer_1.last_name)
  end
end 