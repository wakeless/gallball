require 'spec_helper'

describe Game do
  it { should belong_to(:sport) }
  it { should belong_to(:loser).class_name("Player") }
  it { should belong_to(:winner).class_name("Player") } 
  it { should_validate_presence_of(:sport).with_message("When you play nothing, there is no winner or loser") }
  it { should validate_presence_of(:winner).with_message("Even life has a winner") }
  it { should validate_presence_of(:loser).with_message("Without losers, there can be no winners") }
end
