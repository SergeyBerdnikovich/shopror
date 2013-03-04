# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :amazon_payment do
    buyerName "MyString"
    buyerEmail "MyString"
    operation "MyString"
    referenceId 1
    paymentReason "MyString"
    transactionAmount 1.5
    status "MyString"
    transactionId "MyString"
    transactionDate "MyString"
    paymentMethod "MyString"
    recipientName "MyString"
    recipientEmail "MyString"
  end
end
