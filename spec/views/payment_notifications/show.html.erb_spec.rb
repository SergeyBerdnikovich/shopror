require 'spec_helper'

describe "payment_notifications/show" do
  before(:each) do
    @payment_notification = assign(:payment_notification, stub_model(PaymentNotification,
      :params => "MyText",
      :cart_id => 1,
      :status => "Status",
      :transaction_id => "Transaction",
      :create => "Create"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Status/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Transaction/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Create/)
  end
end
