class Score
  
  
  include Mongoid::Document
  include Mongoid::Timestamps  

  field :score, type: Integer
  field :player_id, type: BSON::ObjectId
  field :accumulate, type: Integer
  field :hand_winner, type: Boolean
  field :achieved, type: Boolean
  field :obtained, type: Symbol

  validates_presence_of :score, :message => "Player must have a score"

  embedded_in :hand

  def add_score(score: nil)
    self.score = score[:score]
    self.player_id = Player.find(score[:player_id]).id
    self
  end
  
  def related_player
    Player.find(self.player_id)
  end
  

end