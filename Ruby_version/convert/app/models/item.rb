class Item < ActiveRecord::Base
 belongs_to :merchant
  belongs_to :purchaser
  
  def self.import(file)
    f = file.open

    first = 1
    f.each_line  do |line|
    # skip the header line
      if first == 1
        # This is the header, no future line will be the header
        first = 0
      else   
        # Separate on those tabs
        a = line.split(pattern="\t")
        
        purchasername = a[0]
        descr = a[1]
        price = a[2]
        purchasecount = a[3]
        merchantaddress = a[4]
        merchantname = a[5]

        # avoid blank lines
        if ( (purchasername != nil) and (merchantname != nil) )
        then
          # try to find the purchaser, in case they're already in the database 
          purchaser = Purchaser.find_by purchasername: purchasername
          if (purchaser == nil)
          then
             # if they're not, add a new record for them
             purchaser = Purchaser.create({purchasername: purchasername})
          end

          # try to find the merchant, in case they're already in the database 
          merchant = Merchant.find_by merchantname: merchantname
          if (merchant == nil)
          then
            # if they're not, add a new record for them
            merchant_params1 = {:merchantaddress => merchantaddress, :merchantname => merchantname}   
            merchant = Merchant.create(merchant_params1)
          end
    
          # now we can make a line for the purchase of this item, 
          # with links to the purchaser and merchant
          item_hash = { :itemdescription => descr, :itemprice => price, :purchasecount => purchasecount, :purchaser_id => purchaser.id, :merchant_id => merchant.id }
        
          Item.create item_hash
        end
      end
   end
   f.close
  end

  # Strong Params
  private 
    def merchant_params
      merchant_params1.permit(:merchantname, :merchantaddress)
    end  
    
end
