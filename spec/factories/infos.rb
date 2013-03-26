# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :info do
    telephone_number "MyString"
    order_id 1
    payment_method "MyString"
  end
end
