class PhaseTen < GameRules
  
  attr_accessor :winner, :valid
  
  @@achieve_threshold = 40
  
  @@obtains =
    {
      s3s3: {name: "Two Sets of Three", short_name: "2 Sets of 3"},
      s3r4: {name: "Set of Three, Run of Four", short_name: "Set 3, Run 4"},
      s4r4: {name: "Set of Four, Run of Four", short_name: "Set 4, Run 4"},            
      r7: {name: "Run of Seven", short_name: "Run 7"},      
      r8: {name: "Run of Eight", short_name: "Run 8"},      
      r9: {name: "Run of Nine", short_name: "Run 9"},      
      s4s4: {name: "Two Sets of Four", short_name: "2 Sets of 4"},            
      c7: {name: "Seven of One Colour", short_name: "7 Colour"},             
      s5s2: {name: "Set of Five, Set of Two", short_name: "Set of 5, Set of 2"},
      s5s3: {name: "Set of Five, Set of Three", short_name: "Set of 5, Set of 3"}
    }
  
  def initialize
    super
  end
  
  def name
    "Phase 10"
  end
  
  def hand_name(hand: nil)
    hand.seq
  end
  
  def has_obtains
    true
  end
  
  def obtains
    @@obtains
  end
  
  def process_hand(current: nil, hands: nil, game: nil)
    @valid = true
    @we_have_a_winner = []
    @game = game
    #super if hands.empty?
    raise if !current
    @seq = current.seq
    hands_list = hands.dup << current    
    self.validate(current: current)
    return self if !@valid
    self.accumulate(current: current, hands: hands_list)
    self.hand_winner(current: current)
    self.achieves(current: current, hands: hands_list)
    self.hand_time(current: current, hands: hands_list)
    !@we_have_a_winner.empty? ? @winner = determine_who_won(current: current) : @winner = nil
    @valid = true
    self
  end
  
  def validate(current: nil)
    # Check to see whether the lowest score is 0
    lowest_score = current.scores.min {|s1, s2| s1.score <=> s2.score}
    if lowest_score.score != 0
      current.errors.add(:base, "The lowest score must be Zero")
      @valid = false
    end
    
    # Check to see if the scores are in units of 5
    current.scores.each do |s|
      if s.score % 5 != 0
        current.errors.add(:score, "Scores must be in units of 5")
        @valid = false 
      end       
    end
  end
  
  def accumulate(current: nil, hands: nil)
    current.scores.each do |player_score| 
      if current.seq == 1
        player_score.accumulate = player_score.score
      else
        last_hand_score =  hands.select {|h| h.seq == current.seq - 1}.first.score(player: player_score.player)
        last_hand_score.accumulate.nil? ? player_score.accumulate = player_score.score : player_score.accumulate = last_hand_score.accumulate + player_score.score  
      end
    end
  end
  
  def hand_winner(current: nil)
    min = current.scores.min {|s1, s2| s1.score <=> s2.score}
    min.hand_winner = true
  end
  
  def achieves(current: nil, hands: nil)
    current.scores.each do |player_score|
      if player_score.score <= @@achieve_threshold
        player_score.achieved = true 
        player_score.obtained = determine_this_obtains(hands: hands, player_id: player_score.player_id)
        @we_have_a_winner << player_score.player_id if player_score.obtained == @@obtains.keys.last
      end
    end
  end
  
  def determine_this_obtains(hands: nil, player_id: nil)
    all_scores = hands.inject([]) {|i, h| i << h.scores.detect {|s| s.player_id == player_id} }
    total_achieved = all_scores.select {|s| s.achieved}.count
    raise if total_achieved > @@obtains.size
    total_achieved == 0 ? nil : @@obtains.keys[total_achieved - 1]
  end
  
  def obtained(sym: nil)
    return if sym.nil?
    @@obtains[sym][:short_name]
  end
  
  def next_to_obtain(hand: nil, hands: nil, player: nil)
    current_hands = hands.select {|h| h.seq <= hand.seq}
    this = determine_this_obtains(hands: current_hands, player_id: player.id)
    keys = @@obtains.keys
    return keys.first if this.nil?    
    idx = keys.index(this)
    keys[idx + 1].nil? ? "Final" : keys[idx + 1] 
  end
  
  def highest_obtains(hands: nil)
    keys = @@obtains.keys
    max_obt = hands.inject([]) {|i, h| i << h.scores.collect {|s| keys.index(s.obtained)}}.flatten.delete_if {|i| i.nil?}.max {|o1, o2| o1 <=> o2}
    max_obt.nil? ? nil : keys[max_obt]
  end
  
  def determine_who_won(current: nil)
    possible = current.scores.select {|s| @we_have_a_winner.include?(s.player_id)}
    possible.min {|s1, s2| s1.accumulate <=> s2.accumulate}.player_id
  end
  
  def hand_time(current: nil, hands: nil)
    previous = hands.select {|h| h.seq == current.seq - 1}
    previous = @game.created_at if !previous
    t = Time.now
    
    binding.pry
  end
  
  
end
