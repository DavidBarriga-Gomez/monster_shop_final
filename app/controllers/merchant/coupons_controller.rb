class Merchant::CouponsController < Merchant::BaseController

  def index
    @coupons = Coupon.where(merchant_id: current_user.merchant_id)
  end

  def new

  end

  def create
    merchant = Merchant.find(current_user.merchant_id)
    @coupon = merchant.coupons.new(coupon_params)
    if @coupon.save
      flash[:success] = "Coupon Created"
      redirect_to merchant_coupons_path
    else
      flash[:error] = "#{@coupon.errors.full_messages.to_sentence}"
      render :new
    end
  end

  def edit
    @coupon = Coupon.find(params[:id])
  end

  def update
    @coupon = Coupon.find(params[:id])
    if @coupon.update(coupon_params)
      flash[:success] = "Coupon Updated!"
      redirect_to merchant_coupons_path
    else
      flash[:error] = "#{@coupon.errors.full_messages.to_sentence}"
      render :edit
    end
  end

  def show
    @coupon = Coupon.find(params[:id])
  end

  def destroy
    Coupon.destroy(params[:id])
    flash[:success] = "Coupon Deleted."

    redirect_to merchant_coupons_path
  end

  private
  def coupon_params
    params.permit(:name, :code, :discount)
  end
end
