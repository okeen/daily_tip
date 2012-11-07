require 'spec_helper'
require 'fakeweb'

describe Link do
  it { should belong_to :tip }

  [:description, :url].each do |attr|
    it { should allow_mass_assignment_of attr }
  end

  it { should validate_presence_of :url }

  context "with a valid url" do
    describe "exports to readable article" do

      before do
        @link = create :link
        FakeWeb.register_uri(:get, @link.url, :body => "<p>Hello World!</p>")
        subject { @link }
      end

      it "use the readability service to transform the file" do
        Readability::Document.any_instance.stubs(:content).returns "Hello World!"
        Readability::Document.expects(:new).with("<p>Hello World!</p>",
          {:tags => ['h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'p', 'img', 'a', 'div']}).returns "Hello World!"

      end
    end
  end
end
