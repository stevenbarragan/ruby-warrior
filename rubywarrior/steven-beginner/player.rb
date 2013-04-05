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

    elsif warrior.feel(:backward).captive?
      warrior.rescue! :backward

    elsif warrior.feel.enemy?
      warrior.attack!

    elsif self.been_attacked?(warrior)

      puts "been_attacked"
      puts "enemy_distance #{self.enemy_distance(warrior)}"
      
      if warrior.health < 15 && self.enemy_distance(warrior) > 1
        warrior.walk! :backward
      elsif self.wissard_forward?(warrior)
        warrior.shoot!
        @shoot = false
      else
        warrior.walk!
        @shoot = false
      end

    elsif self.attack_distance?( warrior )

      puts "attack_distance"
      puts "shoot #{@shoot}"
      
      if @shoot
        
        if warrior.health < 15
          warrior.rest!
        else

          if self.cautive_back?(warrior)
            warrior.walk! :backward
          else
            warrior.walk!
          end

        end

        @shoot = false

      else
        warrior.shoot!
        @shoot = true
        
      end

    elsif warrior.health > 15 || self.look_stairs?(warrior)
      puts "walt "
      puts "warrior.health > 15 #{warrior.health}"
      puts "look_stairs #{self.look_stairs?(warrior)}"

      warrior.walk!

    else
       warrior.rest!

    end
  		
  	@health = warrior.health

  end

  def wissard_forward?(warrior)
    puts "Last_health #{@health}"
    puts "health #{warrior.health}"
    @health - warrior.health == 11
  end

  def cautive_back?(warrior)
    for feel in warrior.look :backward
      return true if feel.captive?  
    end

    false
  end

  def enemy_distance(warrior)
    count = 0

    for feel in warrior.look
      return count if feel.enemy?
      count += 1
    end

  end

  def look_stairs?(warrior)
    stairs =  false

    for feel in warrior.look
      return false if feel.enemy?
      stairs =  true if feel.stairs?
    end

    stairs

  end

  def attack_distance?(warrior)
    enemy = false
    
    for feel in warrior.look
      if feel.enemy?
        enemy = true
      elsif feel.captive?
        return false
      end
    end

    enemy
  end

  def been_attacked?(warrior)
  	warrior.health < @health
  end

end


