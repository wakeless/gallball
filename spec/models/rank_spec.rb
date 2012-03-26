require 'spec_helper'

describe Rank do
  it { should belong_to(:player) }
  it { should belong_to(:sport) }
  it { should validate_presence_of(:player) }
  it { should validate_presence_of(:sport) }
  it { should validate_presence_of(:value) }
end
