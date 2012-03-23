require 'spec_helper'

describe Game do
  it { should validate_presence_of(:winner).with_message("Even life has a winner") }
  it { should validate_presence_of(:loser).with_message("Without losers, there can be no winners") }
end
