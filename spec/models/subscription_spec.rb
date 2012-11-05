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
end
