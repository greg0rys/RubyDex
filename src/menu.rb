# frozen_string_literal: true

# The menu for the entire program modularized
module Menu
  def main_menu
  end
  
  # menu for displaying Pokemon moves
  # @param pocket_monster a Pokemon Object to get move data
  def move_menu(pocket_monster)
    return false unless pocket_monster.valid? # TODO: make this valid? meth
    puts "Choose from the following:\n1. Display Level Moves\n2. Display TM moves\n3. Display All Moves\n4. Skip Moves"
    choice = Menu_Helper::move_input

    case choice
    when 1
      pocket_monster.display_level_moves
    when 2
      pocket_monster.display_tm_moves
    when 3
      pocket_monster.display_all_moves
    when 4
      main_menu
    else
      puts 'Unknown error occured restarting..'
      main_menu
    end
  end

end
