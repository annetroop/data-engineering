class Merchant < ActiveRecord::Base
  has_many  :items
  validates :merchantname,  presence: true,
                            uniqueness: true  
end
