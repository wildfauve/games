module ApplicationHelper
  
  def game_types_select
    Game.game_types.map {|type, conf| [conf[:name], type]}
  end
  
end
