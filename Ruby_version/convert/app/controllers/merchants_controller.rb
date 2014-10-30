class MerchantsController < ApplicationController
 
  def new
  end

  def create
    @merchant = Merchant.new(merchant_params)
    @merchant.save
    redirect_to @merchant
  end

  def show
    @merchant = Merchant.find(params[:id])
  end
  
  def index
    @merchants = Merchant.all
  end
  
  private 
    def merchant_params
      params.require(:merchant).permit(:merchantname, :merchantaddress)
  end
end
