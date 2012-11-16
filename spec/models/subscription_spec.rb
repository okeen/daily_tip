require 'spec_helper'

describe Subscription do
  it { should belong_to :user }

  %w(user_id state).each do |attr|
    it { should_not allow_mass_assignment_of attr }
  end

  context "A brand new subscription" do
    before(:each) do
      @tips = create_list :tip, 10
      @user = create :user
      @subscription = create :subscription, user: @user
      subject { @subscription }
      pending "How can I test this?"
    end

    its(:state) { should eq "active" }
  end

  describe "delivers daily tips" do

    context "of all the popular tips with a count of 10" do
      before do
        @older_tips = create_list :tip, 5, created_at: 48.hours.ago
        @subscription = create :daily_subscription, user: @user, tip_count: 10, tip_scope: "all"
        Subscription.deliver_daily_tips!
        subject { @subscription }
      end

      it "selects the last 24 hours tips" do
        Tip.expects(:created_the_last_24_hours).once
      end

      it "delivers the tip to the subscribers" do
        SubscriptionsMailer.expects(:daily_tip).with(@tips, @user)
      end

    end
  end
end
