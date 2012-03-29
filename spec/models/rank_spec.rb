require 'spec_helper'

describe Rank do
  it { should belong_to(:player) }
  it { should belong_to(:sport) }
  it { should validate_presence_of(:player) }
  it { should validate_presence_of(:sport) }
  it { should validate_presence_of(:value) }
  
  describe "#for_sport" do 
    let (:tennis) { FactoryGirl.create(:sport, :name => 'Tennis') }
    before {
      FactoryGirl.create(:rank)
      FactoryGirl.create(:rank, :sport => tennis)
    }
    
    it {
      ranks = Rank.all() 
      ranks.length.should == 2
    }
    
    it {  
      Rank.for_sport(tennis).length.should == 1
    }
    
  end
  
  describe "#current_rank" do
    before {
      player1 = FactoryGirl.create(:player)
      player2 = FactoryGirl.create(:player)
      sport1 = FactoryGirl.create :sport
      
      FactoryGirl.create(:rank, :player => player1, :sport => sport1)
      FactoryGirl.create(:rank, :player => player1, :sport => sport1)
      FactoryGirl.create(:rank, :player => player2, :sport => sport1)
      FactoryGirl.create(:rank, :player => player2, :sport => sport1)
    }
    
    it { Rank.all().length.should == 4 }
    it { Rank.current_ranks.length.should == 2 }
  end
end
