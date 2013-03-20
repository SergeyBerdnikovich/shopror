# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page do
    about_us "MyText"
    contact_us "MyText"
    conditions "MyText"
    faq "MyText"
  end
end
