class GamesController < ApplicationController
  
  def index
    @games = Game.all
    respond_to do |format|
      format.html
      format.json
    end
  end
  
  def new
    @game = Game.new
  end
  
  def create
    @game = Game.create_it(params[:game])
    respond_to do |format|
      if @game.valid?
        format.html { redirect_to games_path }
        format.json
      else
        format.html { render action: "new" }
        format.json
      end
    end      
  end
  
  def show
    @game = Game.find(params[:id]) if !@game
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
        format.json
      else
        format.html { render action: "edit" }
        format.json
      end
    end      
    
  end
    
  
end