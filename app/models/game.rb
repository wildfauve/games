class Game
  
  @@game_types = {
    phase_10: {name: "Phase Ten", rules_class: :phase_ten},
    five_crowns: {name: "5 Crowns", rules_class: :five_crowns}
  }
  
  include Mongoid::Document
  include Mongoid::Timestamps  

  validates_presence_of :game_type, :message => "You need to include a game type"
  validates_presence_of :play_date, :message => "You need to include a play date"  

  field :play_date, type: Time, default: Time.now
  field :game_type, type: Symbol  
  field :winner_id, type: BSON::ObjectId

  has_and_belongs_to_many :players
  embeds_many :hands
  
  def self.game_types
    @@game_types
  end
  
  
  def self.create_it(game: nil)
    g = Game.new(game)
    g.save
    g
  end
  
  def delete_it
    self.destroy
    self
  end

  def game_name
    @@game_types[self.game_type][:name]
  end
  
  def rules
    GameRules.rules_factory(game: @@game_types[self.game_type][:rules_class])
  end
  
  def has_a_winner
    self.winner_id ? true : false
  end
  
  def winner
    Player.find(winner_id)
  end
  

end