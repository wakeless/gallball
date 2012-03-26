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
      rank9Ball = FactoryGirl.create(:rank)
      rankTennis = FactoryGirl.create(:rank, :sport => tennis)
    }
    
    it {
      ranks = Rank.all() 
      ranks.length.should == 2
    }
    
    it {  
      Rank.for_sport(tennis).length.should == 1
    }
    
  end
end
