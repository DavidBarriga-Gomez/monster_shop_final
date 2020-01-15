class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def initialize(contents)
    @contents = contents
  end

  def coupon_total(merchant_id, discount)
    @contents.sum do |item_id,quantity|
      item = Item.find(item_id)
      if item.merchant_id == merchant_id
        (item.price * quantity) - (item.price * quantity) * (discount * 0.01)
      else
        item.price * quantity
      end
    end
  end
end
