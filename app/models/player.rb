class Player
  
  include Mongoid::Document
  include Mongoid::Timestamps  
  
  
  field :name, :type => String
  
  validates_uniqueness_of :name
  
  has_and_belongs_to_many :games
  

  def self.create_it(params)
    player = self.new(params)
    player.save
    player
  end
  
  def update_it(params)
    self.attributes = (params[:player])
    save
  end
  
  def number_of_wins
    Game.where(winner_id: self.id).count
  end
  
  def played
    self.games.count
  end

end