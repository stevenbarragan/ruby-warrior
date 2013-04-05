class Player
  
  def initialize()
  	@health = 20
    @direccion = false
  end

  def play_turn(warrior)

    @direccion = !@direccion if self.feel(warrior).wall?

    feel = self.feel(warrior)

  	if feel.enemy?
    	warrior.attack!

    elsif feel.captive?

      self.rescue!(warrior)

    elsif self.been_attached?(warrior)

      if warrior.health < 10
        self.go_back!(warrior)
      else
        self.walk!(warrior)
      end

    elsif warrior.health > 15 || feel.stairs?
      
      self.walk!(warrior)

    else
       warrior.rest!

    end
  		
  	@health = warrior.health

  end

  def go_back!(warrior)
    @direccion ? warrior.walk!(:backward) : warrior.walk!
  end

  def been_attached?(warrior)
  	warrior.health < @health
  end

  def rescue!(warrior)
    @direccion ? warrior.rescue! : warrior.rescue!(:backward)
  end

  def feel(warrior)
    @direccion ? warrior.feel : warrior.feel(:backward)
  end

  def walk!(warrior)
    @direccion ? warrior.walk! : warrior.walk!(:backward)
  end

end


