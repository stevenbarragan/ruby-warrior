class Player
  
  def initialize()
  	@health = 20
  end

  def play_turn(warrior)

  	if warrior.feel.enemy?
    	warrior.attack!
    elsif warrior.feel.captive?
      warrior.rescue!
    else
      if self.been_attached?(warrior) || warrior.health > 15
        warrior.walk!
      else
        warrior.rest!
      end
    end
  		
  	@health = warrior.health

  	puts "Healt #{ @health }"

  end

  def been_attached?(warrior)
  	warrior.health < @health
  end


end


