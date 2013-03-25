require 'spec_helper'

describe "messages/edit" do
  before(:each) do
    @message = assign(:message, stub_model(Message,
      :from_user_id => 1,
      :to_user_id => 1,
      :text => "MyText",
      :is_read => false
    ))
  end

  it "renders the edit message form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => messages_path(@message), :method => "post" do
      assert_select "input#message_from_user_id", :name => "message[from_user_id]"
      assert_select "input#message_to_user_id", :name => "message[to_user_id]"
      assert_select "textarea#message_text", :name => "message[text]"
      assert_select "input#message_is_read", :name => "message[is_read]"
    end
  end
end
