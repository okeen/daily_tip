require 'spec_helper'

describe Subscription do
  it { should belong_to :user }

  %w(user_id state).each do |attr|
    it { should_not allow_mass_assignment_of attr }
  end

  context "A brand new subscription" do
    before(:each) do
      subject { create :subscription }
    end

    its(:state) { should eq "active" }
  end

  describe "deliver_daily_tips" do
    before do
      @tip = create :tip
      @user = @tip.author
      @subscription = create :subscription
    end

    it "loads a tip from today" do
      Tip.expects(:from_today).returns [@tip]
    end

    it "delivers the tip to the subscribers" do
      Subscription.expects(:active).returns [@subscription]
      SubscriptionsMailer.expects(:daily_tip).with(@tip, @user)
    end
    Subscription.deliver_daily_tips!
  end
end
