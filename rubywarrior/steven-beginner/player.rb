class Player
  
  def initialize()
  	@health = 20
    @shots = false
  end

  def play_turn(warrior)

    if warrior.feel.wall?
      warrior.pivot!

    elsif warrior.feel.captive?
      warrior.rescue!

    elsif warrior.feel.enemy?
      warrior.attack!

    elsif self.been_attacked?(warrior)
      
      if warrior.health < 10 && self.enemy_distance(warrior) > 2
        warrior.walk! :backward
      else
        warrior.walk!
      end

    elsif self.attack_distance?( warrior )
      
      if @shoot
        if warrior.health < 15
          warrior.rest!
        else
          warrior.walk!
        end

        @shoot = false

      else
        warrior.shoot!
        @shoot = true
        
      end

    elsif warrior.health > 15 || self.look_stairs?(warrior)
      warrior.walk!

    else
       warrior.rest!

    end
  		
  	@health = warrior.health

  end

  def enemy_distance(warrior)
    count = 0
    
    warrior.look.each{|feel|
      return count if feel.enemy?
      count += 1
    }

  end

  def look_stairs?(warrior)
    stairs =  false
    warrior.look.each { |feel|
      return false if feel.enemy?
      stairs =  true if feel.stairs?
    }
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

  def been_attacked?(warrior)
  	warrior.health < @health
  end

end


