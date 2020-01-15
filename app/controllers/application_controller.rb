class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :cart, :current_user, :current_default?, :current_merchant_employee?, :current_merchant_admin?, :current_admin?, :current_coupon, :coupon_total

  def cart
    @cart ||= Cart.new(session[:cart] ||= Hash.new(0))
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_coupon
    @current_coupon ||= Coupon.find(session[:coupon_id]) if session[:coupon_id]
  end

  def current_default?
    current_user && current_user.default?
  end

  def current_merchant_employee?
    current_user && current_user.merchant_employee?
  end

  def current_merchant_admin?
    current_user && current_user.merchant_admin?
  end

  def current_admin?
    current_user && current_user.admin?
  end

  # def coupon_total(merchant_id, discount)
  #   @contents.sum do |item_id,quantity|
  #     item = Item.find(item_id)
  #     if item.merchant_id == merchant_id
  #       (item.price * quantity) - (item.price * quantity) * (discount * 0.01)
  #     else
  #       item.price * quantity
  #     end
  #   end
  # end
end
