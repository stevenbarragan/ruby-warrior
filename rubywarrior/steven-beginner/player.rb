class Player
  
  def initialize()
  	@health = 20
    @shots = 0
  end

  def play_turn(warrior)

    if warrior.feel.wall?
      warrior.pivot!

    elsif warrior.feel.captive?
      warrior.rescue!

    elsif warrior.feel.enemy?
      warrior.attack!

    elsif self.been_attached?(warrior)
      
      if warrior.health < 10 && self.enemy_distance(warrior) > 2
        warrior.walk! :backward
      else
        warrior.walk!
      end

    elsif self.attack_distance?( warrior )
      
      if @shoot == 0
        warrior.shoot!
        @shoot += 1
      else
        if warrior.health < 10
          warrior.rest!
        else
          warrior.walk!
        end
        @shoot = 0
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
    warrior.look.each { |feel| 
      return true if feel.stairs?
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

  def been_attached?(warrior)
  	warrior.health < @health
  end

end


