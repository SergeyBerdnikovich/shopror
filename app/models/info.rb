class Info < ActiveRecord::Base
  attr_accessible :order_id, :payment_method, :telephone_number
  belongs_to :order
end
