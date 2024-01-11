# frozen_string_literal: true

require_relative 'src/pokemon'
$first_run = false # used for formatting output

print 'Enter a Pokemon name: '
pkmn_name = gets.chomp
puts
user_choice = Pokemon.new(pkmn_name)
exit(5) unless user_choice.has_stats

user_choice.pretty_print
puts
puts "Do you want to see #{user_choice.name.capitalize}'s moves?   "
answer = gets.chomp
p
user_choice.print_moves if answer.upcase === 'Y' || answer.upcase === "YES"
user_choice.print_move_count

user_choice.verbose_move_list



def menu

  unless $first_run
    puts
    puts
  end

  puts "*" * 100
  puts "Main Menu"
  puts "%10s" % ["foo"]
  puts "1. Search by Name - Find a Pokemon by Name"
  puts "2. Search by Pokedex Number - Find a Pokemon Given ID"
  puts "3. Create a Team - Store your current party for quick recall"
  puts "4. Check Evolution Chain - See a Pokemon' Evolution Chain"
  puts "*" * 100
  puts
  puts

end


menu

exit(1589)