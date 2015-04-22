class GameRules
  
  include Publisher
    
  def self.rules_factory(game: nil)
    game.to_s.split("_").collect(&:capitalize).join.constantize.new
  end
  
  def initialize
  end
  
  def process_hand
    raise
  end
  
  def name
    raise
  end
  
  def hand_name(hand: nil)
    raise
  end
    
  def validate(current: nil)
    raise
  end
  
  def accumulate(current: nil, hands: nil)
    raise
  end
  
  def hand_winner(current: nil)
    raise
  end
  
  def achieves(current: nil, hands: nil)
    raise
  end
  
  def determine_this_obtains(hands: nil, player_id: nil)
    raise
  end
  
  def obtained(sym: nil)
    raise
  end
  
  def determine_who_won(current: nil)
    raise
  end
  

end
