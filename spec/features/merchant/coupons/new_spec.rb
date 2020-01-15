require 'rails_helper'

RSpec.describe 'As A Merchant', type: :feature do
  before(:each) do
    @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @merchant_employee = User.create!(name: 'merchant_employee', address: 'merchant_employee_address', city: 'merchant_employee_city', state: 'merchant_employee_state', zip: 12345, email: 'merchant_employee_email', password: 'p', password_confirmation: 'p', role: 1, merchant: @bike_shop)

    visit('/')
    click_on('Login')
    fill_in :email, with: @merchant_employee.email
    fill_in :password, with: @merchant_employee.password
    click_on('Submit')
  end

  it 'A Coupon can be created' do
    click_on('View Your Coupons')
    fill_in :name, with: 'coupon name'
    fill_in :code, with: 'coupon code'
    fill_in :discount, with: 50.0
    click_on('Submit')
    expect(current_path).to eq("/merchants/#{@merchant_employee.id}/coupons")

    expect(page).to have_content('coupon name')
    expect(page).to have_content('coupon code')
    expect(page).to have_content(50)
  end
end
