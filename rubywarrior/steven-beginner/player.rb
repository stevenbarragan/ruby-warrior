class Player
  
  def initialize()
  	@health = 20
  end

  def play_turn(warrior)

    if warrior.feel.wall?
      warrior.pivot!

    elsif warrior.feel.captive?
      warrior.rescue!

    elsif warrior.feel.enemy?
      warrior.attack!
      
    elsif self.been_attached?(warrior)
      if warrior.health < 10
        warrior.walk! :backward
      else
        warrior.walk!
      end

    elsif self.attack_distance?( warrior )
      warrior.shoot!


    elsif warrior.health > 15 || warrior.feel.stairs?
      warrior.walk!

    else
       warrior.rest!

    end
  		
  	@health = warrior.health

  end

  def attack_distance?(warrior)
    enemy = false
    
    warrior.look.each { |feel|
      if feel.enemy?
        enemy = true
      elsif feel.captive?
        return false
      end
    }

    enemy
  end

  def been_attached?(warrior)
  	warrior.health < @health
  end

end


