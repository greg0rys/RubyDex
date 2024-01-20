# frozen_string_literal: true

# Much like Poke_Storage this represents a 6 monster team a user may have
class Poke_Team < Poke_Storage
  attr_accessor :team_size, :lead_pokemon

  def initalize
    @team = {}
    @team_size = 0
    @lead_pokemon = nil
  end

  def add_to_team(pocket_monster)
    return false unless pocket_monster.is_a?(Pokemon)

    @team[pocket_monster.name] = pocket_monster
    @team_size += 1
    @lead_pokemon = pocket_monster.name
  end

  # remove a pokemon from the team
  def remove_from_team 
  end

  # get a list of all types this team is strong against 
  def list_team_advantages 
  end

  # get a list of types this team is weak against
  def list_team_weakness 
  end

  # get a given pokemon from the team to analyze 
  def get_team_member 
  end



end
