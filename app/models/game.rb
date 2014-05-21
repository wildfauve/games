class Game
  
  @@game_types = {
    phase_10: {name: "Phase Ten"},
    five_crowns: {name: "5 Crowns"}
  }
  
  include Mongoid::Document
  include Mongoid::Timestamps  

  field :play_date, type: Time
  field :game_type, type: Symbol  

  has_and_belongs_to_many :players
  
  def self.game_types
    @@game_types
  end

end