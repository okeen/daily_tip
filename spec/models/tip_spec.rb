require 'spec_helper'

describe Tip do
  it { should belong_to :author }
  it { should validate_presence_of :author_id }
end
