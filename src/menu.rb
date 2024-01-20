# frozen_string_literal: true

# The menu for the entire program modularized
require_relative 'driver'
include Driver

module Menu

  def put_lines
    2.times { puts }
  end

  def main_menu
    put_lines

    puts '*' * 100
    puts 'Main Menu'
    puts '1. Search by Name - Find a Pokemon by Name'
    puts '2. Search by Pokedex Number - Find a Pokemon Given ID'
    puts '3. Create a Team - Store your current party for quick recall'
    puts "4. Check Evolution Chain - See a Pokemon' Evolution Chain"
    puts '5. Number of Pokemon in Storage'
    puts '6. List Pokemon in Storage'
    puts '7. Remove a Pokemon from Storage'
    puts '*' * 100
    print 'Enter Menu Choice: '
    user_input = Integer(gets.chomp) # convert the string input to an int
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
    when 5
      puts "Total Pokemon in Storage: #{Driver::store_count}"
      main_menu
    when 6
      # need to add checks for zero in storage!
      Driver::list_pokemon_storage
      system('sleep 2')
      main_menu
    when 7
      Driver::remove_pokemon
      main_menu
    else
      puts 'INVALID CHOICE TRY AGAIN'
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
    # TODO this needs to feel more interactive, we should be asking the user 'are you done with
    # this pokemon?' before going to the main_menu each time.
    case choice
    when 1
      pocket_monster.display_level_moves
      puts 'Do you want to display moves learned by TM?: '
      pocket_monster.display_tm_moves if gets.chomp.upcase == 'Y'
    when 2
      pocket_monster.display_tm_moves
    when 3
      pocket_monster.display_all_moves
    when 4
    else
      puts 'Unknown error occured restarting..'
    end
    main_menu
  end

  def new_pokemon_menu(pocket_monster)
    pocket_monster.pretty_print
    pocket_monster.print_moves
    pocket_monster.print_move_count

    puts 'Press return to go back to the Main Menu...'

    # if user just pushed return then == '' will be true
    # implement the ability to press return to go back to main menu after all actions
    main_menu if gets.chomp == '' # this is the main menu call that is currenlty causing it to
    # loop to
    # main change
    # this l8r
  end

  # module end
end
