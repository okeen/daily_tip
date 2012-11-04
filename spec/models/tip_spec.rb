require 'spec_helper'

describe Tip do
  it { should validate_presence_of :author }
end
