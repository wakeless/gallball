FactoryGirl.define do
  factory :player do
    name 'Test Player'
  end
  
  factory :sport do
    name '9 Ball'
  end
  
  factory :rank do
    player { FactoryGirl.create(:player) }
    sport { FactoryGirl.create(:sport) }
    value 1000
  end
  
  factory :game do
    winner { FactoryGirl.create(:player) }
    loser { FactoryGirl.create(:player) }
    sport { FactoryGirl.create(:sport) }
  end
end