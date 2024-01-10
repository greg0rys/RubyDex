# frozen_string_literal: true

require_relative 'pokemon'
print 'Enter a Pokemon name: '
pkmn_name = gets.chomp
puts
user_choice = Pokemon.new(pkmn_name)

user_choice.pretty_print
puts
puts "Do you want to see #{user_choice.name.capitalize}'s moves?   "
answer = gets.chomp
p
user_choice.print_moves if answer.upcase == 'Y'
user_choice.print_move_count

user_choice.verbose_move_list
