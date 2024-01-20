# frozen_string_literal: true

# The menu for the entire program modularized
require_relative './driver'
include Driver

module Menu

  def put_lines
    2.times{puts}
  end
  def main_menu
    user_input = ''
    put_lines

    puts '*' * 100
    puts 'Main Menu'
    puts '1. Search by Name - Find a Pokemon by Name'
    puts '2. Search by Pokedex Number - Find a Pokemon Given ID'
    puts '3. Create a Team - Store your current party for quick recall'
    puts "4. Check Evolution Chain - See a Pokemon' Evolution Chain"
    puts '*' * 100
    print 'Enter Menu Choice: '
    user_input = Integer(gets.chomp) #convert the string input to an int
    process_choice(user_input)
    put_lines
  end

  def process_choice(choice)
    return NameError if choice.zero?

    case choice
      when 1
        Driver::search_name
      when 2
        Driver::search_idx_num
      when 3
        Driver::create_team
      when 4
        Driver::get_evolution_chain
      else
        puts "INVALID CHOICE TRY AGAIN"
        main_menu
    end

  end
  # menu for displaying Pokemon moves
  # @param pocket_monster a Pokemon Object to get move data
  def move_menu(pocket_monster)
    return false unless pocket_monster.valid? # TODO: make this valid? meth
    puts "Choose from the following:\n1. Display Level Moves\n2. Display TM moves\n3. Display All Moves\n4. Skip Moves"
    choice = Menu_Helper::move_input

    # we always go back to the main menu after we display the moves
    #TODO this needs to feel more interactive, we should be asking the user 'are you done with
    # this pokemon?' before going to the main_menu each time.
    case choice
      when 1
        pocket_monster.display_level_moves
        puts 'Do you want to display moves learned by TM?: '
        pocket_monster.display_tm_moves if gets.chomp.upcase == 'Y'
        main_menu
      when 2
        pocket_monster.display_tm_moves
        main_menu
      when 3
        pocket_monster.display_all_moves
        main_menu
      when 4
        main_menu
      else
        puts 'Unknown error occured restarting..'
        main_menu
    end
  end

  # module end
  end
  



