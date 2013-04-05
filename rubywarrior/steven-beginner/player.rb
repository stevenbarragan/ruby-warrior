class Player
  
  def initialize()
  	@health = 20
  end

  def play_turn(warrior)
  	if warrior.feel.empty?
  		if self.been_attached?(warrior) || warrior.health > 15
	    	warrior.walk!
	    else
	    	warrior.rest!
	    end
    else
    	warrior.attack!
  		
  	@health = warrior.health

  	puts "Healt #{ @health }"

    end
  end

  def been_attached?(warrior)
  	warrior.health < @health
  end


end


