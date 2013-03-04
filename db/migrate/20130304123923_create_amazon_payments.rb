class CreateAmazonPayments < ActiveRecord::Migration
  def change
    create_table :amazon_payments do |t|
      t.string :buyerName
      t.string :buyerEmail
      t.string :operation
      t.integer :referenceId
      t.string :paymentReason
      t.float :transactionAmount
      t.string :status
      t.string :transactionId
      t.string :transactionDate
      t.string :paymentMethod
      t.string :recipientName
      t.string :recipientEmail

      t.timestamps
    end
  end
end
