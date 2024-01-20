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

  attr_reader :runs

 @store = Poke_Storage.new
  # search for a Pokemon by name using the query
  # TODO this method needs to be able to display the error the query has the potential to throw
  #
  def search_name
    print 'Enter a Pokemon name: '
    pkmn_name = gets.chomp
    puts
    user_choice = Pokemon.new(pkmn_name)
    puts "Success collected #{user_choice.name}"
    Menu.move_menu(user_choice)

  end
end
