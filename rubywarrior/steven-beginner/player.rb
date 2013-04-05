class Player
  
  def initialize()
  	@health = 20
  end

  def play_turn(warrior)

    if warrior.feel.wall?
      warrior.pivot!

  	elsif warrior.feel.enemy?
    	warrior.attack!

    elsif warrior.feel.captive?
      warrior.rescue!

    elsif self.been_attached?(warrior)
      if warrior.health < 10
        warrior.walk! :backward
      else
        warrior.walk!
      end

    elsif warrior.health > 15 || warrior.feel.stairs?
      warrior.walk!

    else
       warrior.rest!

    end
  		
  	@health = warrior.health

  end

  def been_attached?(warrior)
  	warrior.health < @health
  end

end


