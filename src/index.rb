# frozen_string_literal: true
require_relative 'pokemon'
print "Enter a Pokemon name: "
pkmn_name = gets.chomp
puts
user_choice = Pokemon.new(pkmn_name)


user_choice.pretty_print


