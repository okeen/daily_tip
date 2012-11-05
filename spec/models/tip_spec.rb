require 'spec_helper'

describe Tip do
  it { should belong_to :author }
  it { should have_many :links }

  %w( title content author_id ).each do |attr|
    it { should validate_presence_of attr }
  end
end
