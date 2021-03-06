require 'spec_helper'

describe "emails/new" do
  before(:each) do
    assign(:email, stub_model(Email,
      :title => "MyString",
      :content => "MyText"
    ).as_new_record)
  end

  it "renders new email form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => emails_path, :method => "post" do
      assert_select "input#email_title", :name => "email[title]"
      assert_select "textarea#email_content", :name => "email[content]"
    end
  end
end
