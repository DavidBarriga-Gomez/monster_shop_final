class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, require: true, on: :create

  validates_presence_of :name, :address, :city, :state, :zip

  has_secure_password

  enum role: ['default', 'merchant_employee', 'merchant_admin', 'admin']
end
