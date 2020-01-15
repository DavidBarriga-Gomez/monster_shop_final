require 'rails_helper'

RSpec.describe 'As A Merchant', type: :feature do
  before(:each) do
    @bike_shop = Merchant.create!(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @merchant_employee = User.create!(name: 'merchant_employee', address: 'merchant_employee_address', city: 'merchant_employee_city', state: 'merchant_employee_state', zip: 12345, email: 'merchant_employee_email', password: 'p', password_confirmation: 'p', role: 1, merchant: @bike_shop)

    @coupon_1 = @bike_shop.coupons.create!(name: "first", code: "first", discount: 40.0)
    @coupon_2 = @bike_shop.coupons.create!(name: "second", code: "second", discount: 20.0)

    @user = User.create!(name: 'user', address: 'user_address', city: 'user_city', state: 'user_state', zip: 12345, email: 'user_email', password: 'p', password_confirmation: 'p', role: 0)

    @order_1 = @user.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, coupon_id: @coupon_1.id)


    visit('/')
    click_on('Login')
    fill_in :email, with: @merchant_employee.email
    fill_in :password, with: @merchant_employee.password
    click_on('Submit')
  end

  it 'Merchant Can Edit A Coupon' do
    click_on('View Your Coupons')
    within "#coupon-#{@coupon_1.id}" do
      click_on('Edit')
    end

    fill_in :name, with: ''
    fill_in :code, with: ''
    fill_in :discount, with: ''
    click_on('Update Coupon')
    expect(page).to have_content("Name can't be blank, Code can't be blank, Discount can't be blank, and Discount is not a number")

    fill_in :name, with: 'this'
    fill_in :code, with: 'thisthing'
    fill_in :discount, with: 77.0
    click_on('Update Coupon')
    expect(current_path).to eq('/merchant/coupons')
    within "#coupon-#{@coupon_1.id}" do
      expect(page).to have_content('this')
      expect(page).to have_content('thisthing')
      expect(page).to have_content(77.0)
    end
  end
end
