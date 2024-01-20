# frozen_string_literal: true

# Poke_Storage is used to cache data about pokemon when they're called to reserve API resources
# as well, it allows us to facilitate the idea of a hosted 'team'
class Poke_Storage
  attr_accessor :has_pokemon, :count, :poke_hash

  def initialize
    @has_pokemon = false
    @count = 0
    @poke_hash = {} # stores pokemon in name => pkmn object format {k,v}
  end

  def add_pokemon(pocket_monster)
    return false unless correct_param?(pocket_monster)

    @poke_hash[pocket_monster.name] = pocket_monster
    @count += 1
    @has_pokemon = true if @count.positive?
  end

  # Remove a Pokemon from the hash
  # @param pocket_monster the name of the pokemon to remove
  # @return false unless the Pokemon's name is found in the hash
  def remove_pokemon(pocket_monster)
    # we can raise an error anytime we want during runtime this way. Type checking to prevent crashing
    return false unless correct_param?(pocket_monster)
    return false unless contains?(pocket_monster.name)

    @poke_hash.delete(pocket_monster)
    true # return true
  end

  # Check the hash to see if the Pokemon is contained in the structure
  def contains?(pocket_monster)
    return false unless correct_param?(pocket_monster)

    @poke_hash.any? { |k, _v| k == pocket_monster.name }
  end

  def get_pokemon(pocket_monster)
    return false unless correct_param?(pocket_monster)
    return nil unless contains?(pocket_monster.name)

    # return the pokemon requested from the hash
    @poke_hash[pocket_monster.name]
  end

  def storage_count
    return 0 if empty?

    @poke_hash.length
  end

  def empty?
    return true if @poke_hash.nil?
    return true if @poke_hash.empty?

    # return false if neither condition above is true
    false
  end

  def clear_storage
    return if empty?

    # because I will not use v in |k,v| I will just call it '_' because delete only takes the key as a param
    @poke_hash.each_key do |k|
      @poke_hash.delete(k)
      @count -= 1
    end

    # reset the hash to an empty structure.
    @poke_hash = {}
  end

  # enforces parameter guards - this method is used to prevent methods from calling Pokemon methods on params that are not Pokemons
  # A user shouldn't be able to make this error occur, instead this type of error is an unaccounted for system error that could occur
  # in the event that it does happen the software should auto-recover to the last position unless unable in which cause system will exit and cause a restart of the program.
  def correct_param?(pocket_monster)
    unless pocket_monster.is_a?(Pokemon)
      puts 'Incorrect Type: Pokemon Required'
      return false
    end

    true
  end
end
