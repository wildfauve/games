class FiveCrowns < GameRules
  
  attr_accessor :winner, :valid
  
  @@achieve_threshold = nil
  
    
  @@hand_seq = ["3 Wild", "4 Wild", "5 Wild", "6 Wild", "7 Wild", "8 Wild", "9 Wild", "J Wild", "Q Wild", "K Wild"]
  
  #@@hand_seq = ["3 Wild", "4 Wild", "5 Wild"]
  
  def initialize
    super
  end
  
  def name
    "5 Crowns"
  end
  
  def hand_name(hand: nil)
    @@hand_seq[hand.seq - 1]
  end
  
  def has_obtains
    false
  end
  
  def process_hand(current: nil, hands: nil, game: nil)
    @we_have_a_winner = nil
    raise if !current
    @seq = current.seq
    hands_list = hands.dup << current        
    self.validate(current: current)
    return self if !@valid
    self.accumulate(current: current, hands: hands_list)
    self.hand_winner(current: current)
    self.determine_if_winner(current: current)
    @winner = @we_have_a_winner if @we_have_a_winner
    @valid = true
    self
  end
  
  def validate(current: nil)
    current.errors.add(:base, "an error")
    @valid = true
  end
  
  def accumulate(current: nil, hands: nil)
    current.scores.each do |player_score| 
      if current.seq == 1
        player_score.accumulate = player_score.score
      else
        last_hand_score =  hands.select {|h| h.seq == current.seq +  - 1}.first.score(player: player_score.player)
        last_hand_score.accumulate.nil? ? player_score.accumulate = player_score.score : player_score.accumulate = last_hand_score.accumulate + player_score.score  
      end
    end
  end
  
  def hand_winner(current: nil)
    min = current.scores.min {|s1, s2| s1.score <=> s2.score}
    min.hand_winner = true
  end
  
  def determine_if_winner(current: nil)
    if current.seq == @@hand_seq.count
      binding.pry
      @we_have_a_winner = current.scores.min {|s1, s2| s1.accumulate <=> s2.accumulate}.player_id
    end      
  end
  
  def next_to_obtain(hand: nil, hands: nil, player: nil)
    @hand_seq[hand.seq - 1]
  end
  
  
end
