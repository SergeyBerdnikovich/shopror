class AmazonPaymentsController < ApplicationController

  def confirm
        #params[:recipientName] - имя продоавца
        #params[:status] статус PS
        #params[:recipientEmail] - продавец
        #params[:transactionAmount] кол денег
        #params[:buyerEmail] "buyer_at0m4eg@gmail.com" - покупатель
        #params[:transactionDate] "1362398752"
        #params[:buyerName] "Vladimir Buyer"
        #params[:operation] "pay"
        #params[:paymentMethod] "Credit Card"
        #params[:transactionId] "17KQKMBIB7U76V5IGBQTV7CL9DUVENZD1L2"
        #params[:referenceId] "MyTransaction-3231001" - ид заказа
        #params[:paymentReason] "decrip 33" - описание

    @payment = AmazonPayment.new(
      :buyerEmail => params[:buyerEmail],
      :buyerName => params[:buyerName],
      :operation => params[:operation],
      :paymentMethod => params[:paymentMethod],
      :paymentReason => params[:paymentReason],
      :recipientEmail => params[:recipientEmail],
      :recipientName => params[:recipientName],
      :referenceId => params[:referenceId],
      :status => params[:status],
      :transaction_amount => params[:transactionAmount],
      :transactionDate => params[:transactionDate],
      :transactionId => params[:transactionId]
    )

    if @payment.save && params[:operation]
      order = Order.find(params[:referenceId])
      order.update_attributes(:completed_at => Time.now, :state => 'paid')
      order.user.store_credit.remove_credit(order.amount_to_credit) if order.amount_to_credit
      order.user.current_cart.shopping_cart_items.each do |cart_item|
        cart_item.inactivate!
      end

      redirect_to(myaccount_orders_path, :notice => 'Payment was successfully created.')
    else
      redirect_to(shopping_orders_path, :notice => 'Payment not created.')
    end
  end
end