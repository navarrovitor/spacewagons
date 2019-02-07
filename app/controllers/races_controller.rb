class RacesController < ApplicationController
  def create
    # ------------------------------------------------------------------
    # This action simulates one race
    # Each race has many laps
    # On each lap, there are three phases:
    # Combat phase: players can destroy eachothers ships based on attacker atk and defender def
    # Attacker gets extra points, destroyed player gets 0 pts this lap
    # Crash phase: players can crash depending on their maneuvrability
    # A player who crashes gets 0 points on this lap
    # Lap phase: the remaning players will complete this lap
    # Each player will get scores for the lap based on their spd and acceleration
    # Also, there is a random element to add dynamicity to the lap
    # Players are sorted according to these lap scores, and these will be the positions they arrive in the lap
    # Players get points on each lap
    # The total race result is the sum of points on each lap
    # In the end of the race, extra points are awarded to:
    # Player who has the most of each stat
    # Player who has the biggest sum of all stats
    # ------------------------------------------------------------------

    # Race constant values
    # How many laps on one race
    n_laps = 17
    # Number of eliminations per lap (on each lap, one player will destroy another)
    # The destroyed player gets 0 points on the lap, the attacking player gets points
    number_of_kills = 2
    # Number of crashes per lap (on each lap, one player will crash and get 0 pts)
    number_of_crashes = 1
    # How much acc and spd are weighted for lap score calculation
    acc_mult = 2
    spd_mult = 1
    # The lap score has also a random element to make it more dynamic, so the
    # player with the best specs doesn't win every lap
    point_rand_spread = 20
    # Points for 1st position on lap
    gold_pts = 6
    # Points for 2nd position on lap
    silver_pts = 4
    # Points for 3rd position on lap
    bronze_pts = 3
    # Points for high positions
    ok_pts = 2
    # Points for low positions
    base_pts = 1
    # Size of the high positions
    ok_zone_size_pct = 0.5
    # Points awarded by elimination
    kill_points = 1
    # How many points for the player who has the higher of each stats
    champ_stats_pts = 4

    # Create new race
    r = Race.new

    # All users on database will participate on the race
    # Except the user "Jabba", which is the shop

    all_racers = User.all.select {|user| user.username != 'Jabba'}

    all_racers.each do |user|
      r.runners << user.id
      r.final_results << 0

      # Get all equiped parts on players and calculate ship total stats
      equiped_parts = user.parts.select { |part| part.is_equiped }

      ship_acc = 0
      equiped_parts.each do |part|
        ship_acc += part.stat_acc
      end
      ship_acc = 1 if ship_acc == 0
      r.runners_acc << ship_acc

      ship_spd = 0
      equiped_parts.each do |part|
        ship_spd += part.stat_spd
      end
      ship_spd = 1 if ship_spd == 0
      r.runners_spd << ship_spd


      ship_man = 0
      equiped_parts.each do |part|
        ship_man += part.stat_man
      end
      ship_man = 1 if ship_man == 0
      r.runners_man << ship_man

      ship_atk = 0
      equiped_parts.each do |part|
        ship_atk += part.stat_atk
      end
      ship_atk = 1 if ship_atk == 0
      r.runners_atk << ship_atk

      ship_def = 0
      equiped_parts.each do |part|
        ship_def += part.stat_def
      end
      ship_def = 1 if ship_def == 0
      r.runners_def << ship_def

    end

    r.save

    # Build each lap! Start with lap no 1
    lap_num = 1

    # Start the lap
    n_laps.times do

      # Initiate the lap to the correct race and correct lap number
      lap = Lap.new
      lap.race_id = r.id
      lap.lap_num = lap_num

      # Initiate lap result variables
      lap.combat_killers = []
      lap.combat_victims = []
      lap.crash_victims = []
      lap.save

      lap.save

      # Initiate lap combat phase variables
      killer_prob_stops = []
      victim_prob_stops = []

      runners_on_lap = []
      r.runners.each do |runner|
        runners_on_lap << runner
      end

      killer = 0
      victim = 0

      # Combat phase
      # There is a defined number of kills per lap, given by number_of_kills
      # Each user has a probability of being the killer proportional to its attack
      # Therefore, all attacks are summed, and the probability that a player will kill
      # is equal to (Player_atk)/(sum_atk)
      # Whoever is declared the killer cannot be the victim of this kill
      # The probability of an user being the victim is inversely proportional to defense
      # The killer is excluded from the calculation
      # Therefore, the probability of dying is inversely proportional to (player_def / sum of player defs - def of attacker)
      # The way the function handles the randomizing is the following:
      # Initiate an array called killer_prob_stops that will have values from 0 to 1
      # Generate one interval inside this array for each potential user
      # The size of the user interval is proportional to its attacked compared to the others
      # Therefore, if there are two users with attack 10 and 30
      # Player 1 probability is 0.25 and player 2 is 0.75
      # killer_prob_stops will be [0, 0.25, 1]
      # Roll a random number
      # If number falls between 0 and 0.25, player 1 is the killer
      # If number falls between 0.25 and 1, player 2 is the killer
      # The same logic is applied to the defense

      number_of_kills.times do |count|

        killer_prob_stops = []
        victim_prob_stops = []
        all_alive_atk = []
        killer_prob_stops = []
        possible_victims = []
        possible_victims_def = []
        victim_prob_stops = []

        all_atk_sum = 0

        runners_on_lap.each do |runner|
          runner_index = r.runners.index(runner)
          all_alive_atk << r.runners_atk[runner_index]
        end

        all_alive_atk.each do |atk|
          all_atk_sum += atk
        end

        killer_stop = 0
        all_alive_atk.each do |atk|
          killer_stop += atk.to_f/all_atk_sum
          killer_prob_stops << killer_stop
        end

        roll = rand()
        killer_prob_stops << roll
        killer_prob_stops.sort!
        killer_index = killer_prob_stops.index(roll)
        killer = runners_on_lap[killer_index]

        runners_on_lap.each do |runner|
          possible_victims << runner if runner != killer
        end

        possible_victims.each do |victim|
          victim_index = r.runners.index(victim)
          possible_victims_def << 1/r.runners_def[victim_index].to_f
        end

        remaining_def_sum = 0
        remaining_def_sum = possible_victims_def.reduce(:+)

        victim_stop = 0
        possible_victims.each do |victim|
          victim_index = possible_victims.index(victim)
          victim_stop += (possible_victims_def[victim_index].to_f)/remaining_def_sum
          victim_prob_stops << victim_stop
        end

        roll = rand()
        victim_prob_stops << roll
        victim_prob_stops.sort!
        victim_index = victim_prob_stops.index(roll)
        victim = possible_victims[victim_index]

        lap.combat_killers << killer
        lap.combat_victims << victim
        runners_on_lap.delete(victim)

      end

      # Check for collisions
      # The logic for collisions is the same for the defense calculation
      # The chance of collision is inversely proportional to maneuvrability

      number_of_crashes.times do
        all_alive_man = []
        all_man_sum = 0
        crash_prob_stops = []
        crash_stop = 0

        runners_on_lap.each do |runner|
          runner_index = r.runners.index(runner)
          all_alive_man << r.runners_man[runner_index]
        end

        all_alive_man.each do |man|
          all_man_sum += man
        end

        all_alive_man.each do |man|
          crash_stop += man.to_f/all_man_sum
          crash_prob_stops << crash_stop
        end

        roll = rand()
        crash_prob_stops << roll
        crash_prob_stops.sort!
        crash_index = crash_prob_stops.index(roll)
        crash = runners_on_lap[crash_index]

        lap.crash_victims << crash
        runners_on_lap.delete(crash)
      end

      # Race among the others
      # Initiate points_on_lap which will hold the amount of points each player made on that lap
      points_on_lap = []
      r.runners.length.times do
        points_on_lap << 0
      end

      # Put players into order

      runner_position = []
      runners_on_lap.each do |runner|
        runner_position << runner
      end

      # strength_on_lap is the calculated strength of a player in the lap
      # The strength increases with acc and spd depending on the track
      # Also, a random factor is applied so the race gets more dynamic and chaotic
      # The remaning players on the lap (the one's who havent died or crashed)
      # Will be ranked in order of their calculated strengths for the lap
      # Points will be awarded based on the player ranking for the lap
      # Points awarded are defined by constants
      strength_on_lap = []
      runners_on_lap.length.times do
        strength_on_lap << 0
      end

      runners_on_lap.each do |runner|
        runner_index = runners_on_lap.index(runner)
        strength = 0
        strength += acc_mult * r.runners_acc[runner_index]
        strength += spd_mult * r.runners_spd[runner_index]
        spread_pct = ((-point_rand_spread..point_rand_spread).to_a.sample.to_f/100)
        strength = (strength * (1 + spread_pct))
        strength_on_lap[runner_index] = strength
      end

      runner_position = runner_position.sort_by { |runner| strength_on_lap[runner_position.index(runner)]}.reverse
      lap.positions = runner_position
      lap.save

      # Calculate the points for lap based on ranking position
      # 1st place gets gold_pts, 2nd gets silver_pts, 3rd gets bronze_pts
      # ok_zone are players who arrive at a high position
      # ok_zone size is defined as a percentage of all players racing
      # Race points
      points_on_lap [lap.race.runners.index(runner_position[0])] += gold_pts
      runner_position.shift
      points_on_lap [lap.race.runners.index(runner_position[0])] += silver_pts
      runner_position.shift
      points_on_lap [lap.race.runners.index(runner_position[0])] += bronze_pts
      runner_position.shift

      ok_zone_size = ((runner_position.length).to_f * ok_zone_size_pct).floor.to_i

      ok_zone_size.times do
        points_on_lap[lap.race.runners.index(runner_position[0])] += ok_pts
        runner_position.shift
      end

      # Players on lower positions that did not die or crash receive few points
      runner_position.each do |runner|
        points_on_lap[lap.race.runners.index(runner)] += base_pts
      end

      # Kill points
      # Users receive extra points for each ship they destroyed on this lap
      lap.combat_killers.each do |killer|
        points_on_lap[lap.race.runners.index(killer)] += kill_points
      end

      lap.points = points_on_lap
      lap_num += 1
      lap.save
    end

    # ------------------------------
    # Lap calculations finish
    # -----------------------------
    # General race calculations being
    # -----------------------------

    # Total points on race
    points_on_race = []
    r.runners.length.times do
      points_on_race << 0
    end

    r.laps.each do |lap|
      arr_pos = 0
      points_on_race.length.times do
        points_on_race[arr_pos] += lap.points[arr_pos]
        arr_pos += 1
      end
    end

    winner_stat = []

    # Points for stats
    # For each stat, the player with the highest sum of that stat wins points
    # This rewards players that bet on a focused strategy on their ships
    # The player with the highest sum of all stats also gets extra points
    # If there is a draw, no player gets points for that stat
    # acc
    top_stat = r.runners_acc.max
    count_stats = r.runners_acc.count(top_stat)
    count_stats == 1 ? winner_stat << r.runners_acc.index(top_stat) : winner_stat << nil
    # spd
    top_stat = r.runners_spd.max
    count_stats = r.runners_spd.count(top_stat)
    count_stats == 1 ? winner_stat << r.runners_spd.index(top_stat) : winner_stat << nil
    # man
    top_stat = r.runners_man.max
    count_stats = r.runners_man.count(top_stat)
    count_stats == 1 ? winner_stat << r.runners_man.index(top_stat) : winner_stat << nil
    # atk
    top_stat = r.runners_atk.max
    count_stats = r.runners_atk.count(top_stat)
    count_stats == 1 ? winner_stat << r.runners_atk.index(top_stat) : winner_stat << nil
    # def
    top_stat = r.runners_def.max
    count_stats = r.runners_def.count(top_stat)
    count_stats == 1 ? winner_stat << r.runners_def.index(top_stat) : winner_stat << nil
    #all
    runners_all = []
    r.runners.each do |runner|
      runner_index = r.runners.index(runner)
      runners_all[runner_index] = 0
      runners_all[runner_index] += r.runners_acc[runner_index]
      runners_all[runner_index] += r.runners_spd[runner_index]
      runners_all[runner_index] += r.runners_man[runner_index]
      runners_all[runner_index] += r.runners_atk[runner_index]
      runners_all[runner_index] += r.runners_def[runner_index]
    end

    top_stat = runners_all.max
    count_stats = runners_all.count(top_stat)
    count_stats == 1 ? winner_stat << runners_all.index(top_stat) : winner_stat << nil

    winner_stat.each do |winner|
      if !winner.nil?
        points_on_race[winner - 1] += champ_stats_pts
      end
    end

    # Finish the race
    r.champs_stats = winner_stat
    r.final_results = points_on_race
    r.save

    # Increase the players global score based on their score on this race
    cur_index = 0
    r.runners.each do |player_id|
      player = User.find(player_id)
      player.score += points_on_race[r.runners.index(player_id)]
      player.save
    end

    redirect_to races_presentation_path
  end

  def presentation
    @race = Race.last
    @laps = []

    @race.laps.each do |lap|
      @laps << lap
    end

    @runners = []
    @race.runners.each do |runner|
      @runners << User.find(runner)
    end

    @race_winner = User.find(@race.runners[@race.final_results.index(@race.final_results.max)])


    # Total number of kills, deaths and crashes per user
    @race_kills = []
    @race_deaths = []
    @race_crashes = []

    @runners.length.times do
      @race_kills << 0
      @race_deaths << 0
      @race_crashes << 0
    end

    @race.laps.each do |lap|
      @race.runners.each do |runner|
        @race_kills[@race.runners.index(runner)] += 1 if lap.combat_killers.include?(runner)
        @race_deaths[@race.runners.index(runner)] += 1 if lap.combat_victims.include?(runner)
        @race_crashes[@race.runners.index(runner)] += 1 if lap.crash_victims.include?(runner)
      end
    end

    # Race highlights: most kills, most deaths, most crashes
    @most_kills = @race_kills.max
    @most_kills_players = []
    it = 0
    @race_kills.each do |kills|
      if kills == @most_kills
        @most_kills_players << @runners[it]
      end
      it += 1
    end

    @most_deaths = @race_deaths.max
    @most_deaths_players = []
    it = 0
    @race_deaths.each do |deaths|
      if deaths == @most_deaths
        @most_deaths_players << @runners[it]
      end
      it += 1
    end

    @most_crashes = @race_crashes.max
    @most_crashes_players = []
    it = 0
    @race_crashes.each do |crashes|
      if crashes == @most_crashes
        @most_crashes_players << @runners[it]
      end
      it += 1
    end

    # Stats highlights: champion of each stat
    @most_acc = @race.runners_acc.max
    @most_acc_players = []
    it = 0
    @race.runners_acc.each do |acc|
      if acc == @most_acc
        @most_acc_players << @runners[it]
      end
      it += 1
    end

    @most_spd = @race.runners_spd.max
    @most_spd_players = []
    it = 0
    @race.runners_spd.each do |spd|
      if spd == @most_spd
        @most_spd_players << @runners[it]
      end
      it += 1
    end

    @most_man = @race.runners_man.max
    @most_man_players = []
    it = 0
    @race.runners_man.each do |man|
      if man == @most_man
        @most_man_players << @runners[it]
      end
      it += 1
    end

    @most_atk = @race.runners_atk.max
    @most_atk_players = []
    it = 0
    @race.runners_atk.each do |atk|
      if atk == @most_atk
        @most_atk_players << @runners[it]
      end
      it += 1
    end

    @most_def = @race.runners_def.max
    @most_def_players = []
    it = 0
    @race.runners_def.each do |defe|
      if defe == @most_def
        @most_def_players << @runners[it]
      end
      it += 1
    end

  end

  def show
  end
end


