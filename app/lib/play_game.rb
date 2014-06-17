class PlayGame
  
  include Publisher
  
  def play_hand(game: nil, hand: nil)
    h = Hand.create_it(hand: hand, seq: game.hands.count + 1)
    if game.valid?
      outcome = game.rules.process_hand(current: h, hands: game.hands)
      if outcome.valid
        game.winner_id = outcome.winner if outcome.winner 
        game.hands << h
        game.save
        if game.valid?
          publish(:game_hand_played, game)
        else
          publish(:game_hand_errors, game, h)
        end
      else
        publish(:game_hand_errors, game, h)
      end
    else
      publish(:game_hand_errors, game, h)      
    end
  end
  
  def re_calc_game(game: nil)
    processed_hands = []    
    game.hands.each do |h|
      processed_hands << h
      outcome = game.rules.process_hand(current: h, hands: processed_hands)
      raise if !outcome.valid
      processed_hands.last == h
      game.winner_id = outcome.winner if outcome.winner 
    end
    game.save
    if game.valid?
      publish(:game_recaled, game)
    else
      raise
    end
    
  end
  
end
