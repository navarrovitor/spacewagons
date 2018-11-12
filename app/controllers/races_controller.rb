class RacesController < ApplicationController
  def create
    number_of_kills = 3
    number_of_crashes = 0
    acc_mult = 1
    spd_mult = 1
    point_rand_spread = 20
    gold_pts = 8
    silver_pts = 6
    bronze_pts = 4
    ok_pts = 2
    base_pts = 1
    ok_zone_size_pct = 0.5
    kill_points = 2
    n_laps = 5
    champ_stats_pts = 6

    r = Race.new

    User.all.each do |user|
      r.runners << user.id
      r.final_results << 0

      equiped_parts = user.parts.select { |part| part.is_equiped }

      ship_acc = 0
      equiped_parts.each do |part|
        ship_acc += part.stat_acc
      end
      r.runners_acc << ship_acc

      ship_spd = 0
      equiped_parts.each do |part|
        ship_spd += part.stat_spd
      end
      r.runners_spd << ship_spd

      ship_man = 0
      equiped_parts.each do |part|
        ship_man += part.stat_man
      end
      r.runners_man << ship_man

      ship_atk = 0
      equiped_parts.each do |part|
        ship_atk += part.stat_atk
      end
      r.runners_atk << ship_atk

      ship_def = 0
      equiped_parts.each do |part|
        ship_def += part.stat_def
      end
      r.runners_def << ship_def

    end

    r.save

    lap_num = 1

    # Start the lap

    n_laps.times do

      lap = Lap.new
      lap.race_id = r.id
      lap.lap_num = lap_num

      lap.combat_killers = []
      lap.combat_victims = []
      lap.crash_victims = []
      lap.save

      lap.save

      killer_prob_stops = []
      victim_prob_stops = []

      runners_on_lap = []
      r.runners.each do |runner|
        runners_on_lap << runner
      end

      killer = 0
      victim = 0

      # Combat phase

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

      points_on_lap = []
      r.runners.length.times do
        points_on_lap << 0
      end

      # Put players into order

      runner_position = []
      runners_on_lap.each do |runner|
        runner_position << runner
      end

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

      # Calculate the points
      # Race points
      points_on_lap [runner_position[0] - 1] += gold_pts
      runner_position.shift
      points_on_lap [runner_position[0] - 1] += silver_pts
      runner_position.shift
      points_on_lap [runner_position[0] - 1] += bronze_pts
      runner_position.shift

      ok_zone_size = ((runner_position.length).to_f * ok_zone_size_pct).floor.to_i

      ok_zone_size.times do
        points_on_lap[runner_position[0] - 1] += ok_pts
        runner_position.shift
      end

      runner_position.each do |runner|
        points_on_lap[runner - 1] += base_pts
      end

      # Kill points
      lap.combat_killers.each do |killer|
        points_on_lap[killer - 1] += kill_points
      end

      lap.points = points_on_lap
      lap_num += 1
      lap.save
    end

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

    # points for stats
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

    r.champs_stats = winner_stat
    r.final_results = points_on_race
    r.save

    cur_index = 0
    points_on_race.each do |point|
      player = User.find(cur_index + 1)
      player.score += points_on_race[cur_index]
      player.save
      cur_index += 1
    end

    redirect_to races_presentation_path
  end

  def presentation
    @race = Race.last
    @lap = @race.laps[0]


  end


  def show
  end
end


