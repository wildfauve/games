class Hand
  
  
  include Mongoid::Document
  include Mongoid::Timestamps  

  field :seq, type: Integer
  field :duration, type: Date

  embedded_in :game
  
  embeds_many :scores
  
  def self.game_types
    @@game_types
  end
  
  
  def self.create_it(hand: nil, seq: 1)
    h = Hand.new.add_scores(hand_scores: hand, seq: seq)
    h
  end

  def add_scores(hand_scores: nil, seq: 1)
    hand_scores.each {|player, score| 
      s = Score.new.add_score(score: score)
      scores << s
    }
    self.seq = seq
    self
  end
  
  def score(player: nil)
    self.scores.where(player_id: player.id).first
  end

end