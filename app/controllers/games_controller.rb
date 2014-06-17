class GamesController < ApplicationController
  
  def index
    @games = Game.all
    respond_to do |format|
      format.html
    end
  end
  
  def new
    @game = Game.new
    @players = Player.all
  end
  
  def create
    @game = Game.create_it(game: params[:game])
    respond_to do |format|
      if @game.valid?
        format.html { redirect_to games_path }
      else
        build_flash_errors(@game)
        format.html { render action: "new" }
      end
    end      
  end
  
  def show
    @game = Game.find(params[:id])
    @rules = @game.rules
    respond_to do |format|
      format.html
    end
    
  end
  
  def edit
    @game = Game.find(params[:id]) if !@game    
  end
  
  def update
    @game = Game.find(params[:id])    
    @game.update_it(params)
    respond_to do |format|
      if @game.valid?
        format.html { redirect_to games_path }
      else
        format.html { render action: "edit" }
      end
    end      
    
  end
  
  def destroy
    @game = Game.find(params[:id])    
    @game.delete_it
    respond_to do |format|
      if @game.valid?
        format.html { redirect_to games_path }
      else
        format.html { render action: "edit" }
      end
    end      
  end
    
  def recalc
    game = Game.find(params[:id])
    pg = PlayGame.new
    pg.add_subscriber(self)        
    pg.re_calc_game(game: game)
  end
  
  def game_recaled(game)
    respond_to do |f|
      f.html {redirect_to game_path game }
    end
  end
  
  
end