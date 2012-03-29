require 'spec_helper'

describe Player do
  let (:golf) { FactoryGirl.create(:sport, :name => 'Golf') }
  let (:tennis) { FactoryGirl.create(:sport, :name => 'Tennis') }
  let (:player) { FactoryGirl.create(:player) }
  let (:player2) { FactoryGirl.create(:player) }
  
  it { should have_many(:games) } #failing
  it { should have_many(:losses) }
  it { should have_many(:wins) }
  it { should have_many(:ranks) }
  it { should validate_presence_of(:name).with_message("People have names, yo") }
  
  describe "#leaderboard" do
    before {
      player = FactoryGirl.create(:player)
      player2 = FactoryGirl.create(:player)
      
      FactoryGirl.create(:rank, :player => player, :sport => tennis, :value => 10)
      FactoryGirl.create(:rank, :player => player, :sport => tennis, :value => 90)
      FactoryGirl.create(:rank, :player => player2, :sport => tennis, :value => 20)
      FactoryGirl.create(:rank, :player => player, :sport => golf, :value => 30)
      FactoryGirl.create(:rank, :player => player2, :sport => golf, :value => 10)
      FactoryGirl.create(:rank, :player => player2, :sport => golf, :value => 40)
    }
    
    it { 
      leaderboard = Player.leaderboard(tennis)
      leaderboard.length.should == 2
      leaderboard.first.value.should == 90
    }

    it { 
      leaderboard = Player.leaderboard(golf)
      leaderboard.length.should == 2
      leaderboard.first.value.should == 40
    }
  end
  
  describe "#rank_for_sport" do
    before {
      FactoryGirl.create(:rank, :sport => tennis, :player => player)
      FactoryGirl.create(:rank, :sport => golf, :player => player)
    }
    
    it { player.ranks == 2 }
    it { player.rank_for_sport(tennis).should == 1000 }
  end
  
  describe "#update_rank" do
    before {
      FactoryGirl.create(:rank, :sport => tennis, :player => player)
      FactoryGirl.create(:rank, :sport => golf, :player => player)
    }
    
    it { player.ranks == 2 }
    it { player.rank_for_sport(tennis).should == 1000 }
    it { 
      player.update_rank(tennis, 1234)
      player.rank_for_sport(tennis).should == 1234 
    }
  end
  
  describe "#games_played" do
    before {
      FactoryGirl.create(:game, :winner => player)
      FactoryGirl.create(:game, :loser => player)
      FactoryGirl.create(:game)
    }
    
    it {
      player.reload
      player.games_played.should == 2
    }
  end
end
