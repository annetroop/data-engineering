class ItemsController < ApplicationController
  
  def new
  end
  
  def create
    # for entering items manually, for initial testing

    # commit the purchaser (ignoring duplicates for now)    
    purchasername = params[:item][:purchasername]
    @purchaser = Purchaser.create({purchasername: purchasername})

    # commit the merchant (ignoring duplicates for now)    
    @merchant_params1 = params[:item].slice(:merchantname,:merchantaddress)    
    @merchant = Merchant.create(merchant_params)
    
    # commit the rest of the item information, with links to purchaser and merchant
    @item_params1 = params[:item].slice(:itemdescription, :itemprice, :purchasecount)
    @item_params1[:purchaser_id] = @purchaser.id
    @item_params1[:merchant_id] = @merchant.id
    @item = Item.create(item_params)
    @item.save
    
    redirect_to @item
  end

  def show
    @item = Item.find(params[:id])
  end
    
  def index
    @items = Item.all
  end

  def import
    Item.import(params[:file])
    redirect_to items_url, notice: "Items imported"
  end
    
  private 
    def item_params
      @item_params1.permit(:itemdescription, :itemprice, :purchasecount, :purchaser_id, :merchant_id)
    end  
    
  private 
    def merchant_params
      @merchant_params1.permit(:merchantname, :merchantaddress)
    end  
     
end
