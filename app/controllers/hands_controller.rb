class HandsController < ApplicationController
  
  def index
  end
  
  def new
    @game = Game.find(params[:game_id])
    @rules = @game.rules
    @hand = Hand.new
    respond_to do |format|
      format.js {render 'hand_form', :layout => false }
    end
  end
  
  
  # "hand"=>{"Juki"=>{"score"=>"10", "player_id"=>"537a68b74d617403c3000000"}, "Col"=>{"score"=>"20", "player_id"=>"537be4e04d6174105e000000"}}
  
  def create
    game = Game.find(params[:game_id])
    hand = PlayGame.new
    hand.add_subscriber(self)        
    hand.play_hand(game: game, hand: params[:hand])
  end
        
  
  def game_hand_played(game)
    respond_to do |f|
      f.html {redirect_to game_path game }
    end
  end

  def game_hand_errors(game, hand)
    respond_to do |f|
      build_multiple_flash_errors(game, hand, hand.scores)
      f.html {redirect_to game_path game }
    end
  end

  
end