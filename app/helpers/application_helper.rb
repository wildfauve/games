module ApplicationHelper
  
  def game_types_select
    Game.game_types.map {|type, conf| [conf[:name], type]}
  end
  
  def player_list_select_old
    Player.all.map {|p| [p.name, p.id]}
  end
  
  def player_list_select
    Player.all.map {|p| [p.name]}
  end
  
end
