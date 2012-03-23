require 'spec_helper'

describe Game do
  it { should validate_presence_of :winner }
  it { should validate_presence_of :loser }
end
