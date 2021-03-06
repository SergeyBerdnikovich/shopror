require 'spec_helper'

describe "pages/edit" do
  before(:each) do
    @page = assign(:page, stub_model(Page,
      :about_us => "MyText",
      :contact_us => "MyText",
      :conditions => "MyText",
      :faq => "MyText"
    ))
  end

  it "renders the edit page form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => pages_path(@page), :method => "post" do
      assert_select "textarea#page_about_us", :name => "page[about_us]"
      assert_select "textarea#page_contact_us", :name => "page[contact_us]"
      assert_select "textarea#page_conditions", :name => "page[conditions]"
      assert_select "textarea#page_faq", :name => "page[faq]"
    end
  end
end
