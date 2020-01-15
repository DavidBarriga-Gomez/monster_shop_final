class AddCouponController < ApplicationController

  def create
    coupon = Coupon.find_by(code: params[:code])
    if coupon.nil?
      flash[:error] = 'Not A Valid Coupon'
    elsif current_user.orders.pluck("coupon_id").include?(coupon.id)
      flash[:error] = 'Coupon Can Not Be Used More Than Once'
    else
      items = Item.where(id: cart.contents.keys)
      use_coupon(coupon, items)
    end
    redirect_to cart_path
  end

  private
    def use_coupon(coupon, items)
      if items.where(merchant_id: coupon.merchant_id).any?
        session[:coupon_id] = coupon.id
        flash[:success] = "Coupon #{coupon.code} applied."
      else
        flash[:error] = 'Coupon Does Not Match Any Items'
      end
    end
end
