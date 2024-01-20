# frozen_string_literal: true

# @author Greg
# @date 01/10/2023
require 'json'
require_relative './mods/pokequery'
require_relative './classes/pokemon'
require_relative './menu'
require_relative './classes/poke_storage'

include Poke_Query

module Driver
 attr_reader :store_count
 @store = Poke_Storage.new
 @store_count = @store.count
  # search for a Pokemon by name using the query
  # TODO this method needs to be able to display the error the query has the potential to throw
  #
  def search_name
    print 'Enter a Pokemon name: '
    pkmn_name = gets.chomp
    puts
    #don't add the pokemon this way make sure this is a valid pokemon first
    @store.add_pokemon(Pokemon.new(pkmn_name)) # we will need to ensure this a pokemon before making this
    # final
    puts "Success #{@store.poke_hash[pkmn_name].name.capitalize} was captured!"
    Menu.new_pokemon_menu(@store.poke_hash[pkmn_name])


  end
end
