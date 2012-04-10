require 'spec_helper'

describe Game do
  let (:player1) { FactoryGirl.create(:player, :name => "Player 1") }
  let (:player2) { FactoryGirl.create(:player, :name => "Player 2") }
  let (:player3) { FactoryGirl.create(:player, :name => "Player 2") }
  
  
  it { should belong_to(:sport) }
  it { should belong_to(:loser).class_name("Player") }
  it { should belong_to(:winner).class_name("Player") } 
  it { should validate_presence_of(:sport).with_message("When you play nothing, there is no winner or loser") }
  it { should validate_presence_of(:winner).with_message("Even life has a winner") }
  it { should validate_presence_of(:loser).with_message("Without losers, there can be no winners") }
  
  describe "#order_scopes" do
    let (:first_game) { FactoryGirl.create(:game) }
    let (:last_game) { FactoryGirl.create(:game) }
    before {
      first_game
      FactoryGirl.create(:game)
      FactoryGirl.create(:game)
      last_game
    }
    
    describe "#order_played" do
      subject { Game.order_played }
      it { subject.first.should == first_game } 
    end
    
    describe "#most_recent" do
      subject { Game.most_recent }
      it { subject.first.should == last_game }
    end
  end
  
  describe "#player_games" do
    before {
      FactoryGirl.create(:game, :winner => player1, :loser => player2)
      FactoryGirl.create(:game, :winner => player3, :loser => player1)
      FactoryGirl.create(:game, :winner => player3, :loser => player2)
    }
    
    describe "#for_player" do
      it { Game.for_player(player1).length.should == 2 }
    end
    
    describe "#games_played" do
      it { Game.games_played(player1).should == 2 }
    end
  end
  
  describe "#update_player_rank" do
    it { 
      player1 = FactoryGirl.build_stubbed(:player)
      player1.stub(:rank_for_sport).and_return(1000)
      player1.stub(:games_played).and_return(0)
      
      player2 = FactoryGirl.build_stubbed(:player)
      player2.stub(:rank_for_sport).and_return(1000)
      player2.stub(:games_played).and_return(0)
      
      game = FactoryGirl.build(:game, :winner => player1, :loser => player2)
      
      game.update_player_rank
      player1.ranks.length.should == 1
      player2.ranks.length.should == 1

      player1.ranks.first.value.should > 1000
      player2.ranks.first.value.should < 1000
    }
  end

  describe "#update_player_rank_multiple" do
    it { 
      sport = FactoryGirl.build(:sport, :name => '9ball')

      player1 = FactoryGirl.create(:player)
      player2 = FactoryGirl.create(:player)

      (1..100).each do |i|
        FactoryGirl.build(:game, :sport => sport, :winner => player1, :loser => player2).update_player_rank
        FactoryGirl.build(:game, :sport => sport, :winner => player2, :loser => player1).update_player_rank
      end

      player1.ranks.first.value.should > 950 
      player2.ranks.first.value.should > 950
    }
  end
  
  describe "#after_save" do
    it {
      player1 = FactoryGirl.build_stubbed(:player)
      player1.stub(:rank_for_sport).and_return(1000)
      player1.stub(:games_played).and_return(0)
      player1.should_receive(:update_rank)
        
      player2 = FactoryGirl.build_stubbed(:player)
      player2.stub(:rank_for_sport).and_return(1000)
      player2.stub(:games_played).and_return(0)
      player2.should_receive(:update_rank)
        
      game = FactoryGirl.build(:game, :winner => player1, :loser => player2)
      game.save
    }
  end
  
   
    
end
