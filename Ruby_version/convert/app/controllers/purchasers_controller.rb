class PurchasersController < ApplicationController
 
  def new
  end

  def create
    @purchaser = Purchaser.new(purchaser_params)
    @purchaser.save
    redirect_to @purchaser
  end

  def show
    @purchaser = Purchaser.find(params[:id])
  end
  
  def index
    @purchasers = Purchaser.all
  end
  
  private 
    def purchaser_params
      params.require(:purchaser).permit(:purchasername)
    end
end
