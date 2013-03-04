class AmazonPayment < ActiveRecord::Base
  attr_accessible :buyerEmail, :buyerName, :operation, :paymentMethod,
                  :paymentReason, :recipientEmail, :recipientName, :referenceId,
                  :status, :transactionAmount, :transactionDate, :transactionId,
                  :transaction_amount

  def transaction_amount=(currency_and_amount)
    currency = parse(currency_and_amount).first
    if currency == 'USD'
      amount = parse(currency_and_amount).last.to_f
    else
      amount = currency.to_f
    end
    self.transactionAmount = amount unless amount == 0.0
  end

  def parse(currency_and_amount)
    @parsed ||= currency_and_amount.split
  end
end
