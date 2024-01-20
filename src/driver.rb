# frozen_string_literal: true

# @author Greg
# @date 01/10/2023
require 'json'
require_relative 'mods/pokequery'
require_relative 'classes/pokemon'
require_relative 'menu'
require_relative 'classes/poke_storage'

include Poke_Query

# The application driver
module Driver
  attr_reader :store_count

  EXIT_SUCCESS = 2500
  EXIT_ERROR = 4040

  @store = Poke_Storage.new
  @store_count = 0
  @generic_pokemon = Pokemon.new # used to create a pokemon object with name
  # search for a Pokemon by name using the query
  # TODO this method needs to be able to display the error the query has the potential to throw
  #
  def search_name
    print 'Enter a Pokemon name: '
    pkmn_name = gets.chomp
    puts
    # don't add the pokemon this way make sure this is a valid pokemon first
    @store.add_pokemon(Pokemon.new(pkmn_name)) # we will need to ensure this a pokemon before making this
    @store_count += 1
    # final
    puts "Success #{@store.poke_hash[pkmn_name].name.capitalize} was captured & sent to storage"
    Menu.new_pokemon_menu(@store.poke_hash[pkmn_name])
  end

  def list_pokemon_storage
    idx = 1
    # the value in the Pokehash is a pokemon object so call .name accessor
    @store.poke_hash.each_value do |v|
      puts "#{idx}. #{v.name.capitalize}"
      idx += 1
    end
  end

  def remove_pokemon
    print 'Enter the Pokemons name you wish to remove: '
    name_to_remove = gets.chomp
    removed = @store.remove_pokemon(name_to_remove)

    unless removed
      puts "Error! #{name_to_remove} was not found in storage"
      return # return back to the menu
    end

    puts "Success #{name_to_remove} was removed from storage"
    @store_count -= 1
  end

  # the user has chosen to end the program code 2500
  # TODO: Have this method delete everything stored in the hash after
  # it has been moved to a save area. RedisDB might be the best here. 
  def end_program
    puts "Thanks for using me goodbye! #{EXIT_SUCCESS}"
    exit(EXIT_SUCCESS)
  end

end
