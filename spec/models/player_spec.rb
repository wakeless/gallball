require 'spec_helper'

describe Player do
  it { should have_many(:games) } #failing
  it { should have_many(:losses) }
  it { should have_many(:wins) }
  it { should have_many(:ranks) }
  it { should validate_presence_of(:name).with_message("People have names, yo") }
  
  
end
