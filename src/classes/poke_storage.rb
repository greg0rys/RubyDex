# frozen_string_literal: true

=begin
Poke_Storage is used to cache data about pokemon when they're called to reserve API resources
as well, it allows us to facilitate the idea of a hosted 'team'
=end
class Poke_Storage
  attr_accessor :has_pokemon, :count

  def initialize
    @has_pokemon = false
    @count = 0
    @poke_hash = {}
  end

  def add_pokemon(pocket_monster)
    @poke_hash[pocket_monster.get_name] = Pokemon.new(pocket_monster)
    @count += 1
    @has_pokemon = true if @count.positive?
  end
end
