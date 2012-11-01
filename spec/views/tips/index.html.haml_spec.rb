require 'spec_helper'

describe "tips/index" do
  before(:each) do
    assign(:tips, [
      stub_model(Tip,
        :title => "Title",
        :content => "MyText"
      ),
      stub_model(Tip,
        :title => "Title",
        :content => "MyText"
      )
    ])
  end

  it "renders a list of tips" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
