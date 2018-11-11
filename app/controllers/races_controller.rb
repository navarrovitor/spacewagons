class RacesController < ApplicationController
  def create

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

    lap1 = Lap.new
    lap1.race_id = r.id
    lap1.save

    killer_prob_stops = []
    victim_prob_stops = []

    runners_on_lap = []
    lap1.race.runners.each do |runner|
      runners_on_lap << runner
    end

    number_of_snipes = 1

    killer = 0
    victim = 0

    number_of_snipes.times do

      all_atk_sum = 0

      all_alive_atk = []
      runners_on_lap.each do |runner|
        runner_index = lap1.race.runners.index(runner)
        all_alive_atk << lap1.race.runners_atk[runner_index]
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
      killer = lap1.race.runners[killer_index]

      possible_victims = []
      runners_on_lap.each do |runner|
        possible_victims << runner if runner != killer
      end

      possible_victims_def = []
      possible_victims.each do |victim|
        victim_index = lap1.race.runners.index(victim)
        possible_victims_def << lap1.race.runners_def[victim_index]
      end

      remaining_def_sum = 0
      remaining_def_sum = possible_victims_def.reduce(:+)

      victim_stop = 0
      possible_victims.each do |victim|
        victim_index = possible_victims.index(victim)
        victim_stop += possible_victims_def[victim_index].to_f/remaining_def_sum
        victim_prob_stops << victim_stop
      end

      roll = rand()
      victim_prob_stops << roll
      victim_prob_stops.sort!
      victim_index = victim_prob_stops.index(roll)
      victim = possible_victims[victim_index]

      lap1.combat_killers << killer
      lap1.combat_victims << victim
    end

   raise


    redirect_to root_path


  end

  def show
  end
end
