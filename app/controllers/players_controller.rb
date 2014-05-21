class PlayersController < ApplicationController
  
  def index
    @players = Player.all
    respond_to do |format|
      format.html
      format.json
    end
  end
  
  def new
    @player = Player.new
  end
  
  def create
    @player = Player.create_it(params[:player])
    respond_to do |format|
      if @player.valid?
        format.html { redirect_to players_path }
        format.json
      else
        format.html { render action: "new" }
        format.json
      end
    end      
  end
  
  def show
    @player = Player.find(params[:id]) if !@player
  end
  
  def edit
    @player = Player.find(params[:id]) if !@player    
  end
  
  def update
    @player = Player.find(params[:id])    
    @player.update_it(params)
    respond_to do |format|
      if @player.valid?
        format.html { redirect_to players_path }
        format.json
      else
        format.html { render action: "edit" }
        format.json
      end
    end      
    
  end
    
  
end