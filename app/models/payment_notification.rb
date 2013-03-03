class PaymentNotification < ActiveRecord::Base
  attr_accessible :cart_id, :params, :status, :transaction_id
  belongs_to :cart
  serialize :params
end
