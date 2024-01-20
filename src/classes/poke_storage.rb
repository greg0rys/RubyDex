# frozen_string_literal: true

=begin
Poke_Storage is used to cache data about pokemon when they're called to reserve API resources
as well, it allows us to facilitate the idea of a hosted 'team'
=end
class Poke_Storage
  attr_accessor :has_pokemon, :count, :poke_hash

  def initialize
    @has_pokemon = false
    @count = 0
    @poke_hash = {}
  end

  def add_pokemon(pocket_monster)
    @poke_hash[pocket_monster.name] = pocket_monster
    @count += 1
    @has_pokemon = true if @count.positive?
  end

  # Remove a Pokemon from the hash
  # @param pmkn_name the name of the pokemon to remove
  # @return false unless the Pokemons name is found in the hash
  def remove_pokemon(pkmn_name)
    return false unless contains?(pkmn_name)
    @poke_hash.delete(pkmn_name)
    true # return true

  end

  # Check the hash to see if the Pokemon is contained in the structure
  def contains?(pkmn_name)
    @poke_hash.any? {|k,v| k == pkmn_name}
  end
end
