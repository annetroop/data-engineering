class Purchaser < ActiveRecord::Base
  has_many  :items
  validates :purchasername, presence: true,
                            uniqueness: true
  end
