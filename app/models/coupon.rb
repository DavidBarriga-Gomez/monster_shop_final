class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :orders

  validates :name, uniqueness: true, presence: true
  validates :code, uniqueness: true, presence: true
  validates_presence_of :discount

  validates_numericality_of :discount, greater_than: 0
  validates_numericality_of :discount, less_than_or_equal_to: 100
end
