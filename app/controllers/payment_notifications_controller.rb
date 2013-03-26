class PaymentNotificationsController < ApplicationController
  protect_from_forgery :except => [:create]

  def create
    PaymentNotification.create!(:params => params, :cart_id => params[:invoice], :status => params[:payment_status], :transaction_id => params[:txn_id])

    if params[:payment_status] == "Completed"
      order = Order.find(params[:invoice])
      order.update_attributes(:completed_at => Time.now, :state => 'paid')
      order.update_inventory
      order.user.store_credit.remove_credit(order.amount_to_credit) if order.amount_to_credit
      order.user.current_cart.shopping_cart_items.each do |cart_item|
        cart_item.inactivate!
      end
    end

    render :nothing => true
  end

end
