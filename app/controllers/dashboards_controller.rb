class DashboardsController < ApplicationController
  
  def game_time_line
    @game = Game.find(params[:game])
    @play = PlayGame.new
    @play.create_time_line(game: @game)
    respond_to do |format|
      format.js {render 'time_line'}
    end
  end
  
  def time_line_event
  end
  
end