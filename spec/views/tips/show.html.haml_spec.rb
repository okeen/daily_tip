require 'spec_helper'

describe "tips/show" do
  before(:each) do
    @tip = assign(:tip, stub_model(Tip,
      :title => "Title",
      :content => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
  end
end
