# frozen_string_literal: true

$x = 0
require 'uri'
require 'net/http'
require 'openssl'
require 'json'
require_relative 'mods/pokequery'

include Poke_Query
# Model a Pocket Monster in the system
class Pokemon
  attr_accessor :name, :id, :height, :weight, :base_experience, :types,
                :abilities, :moves, :move_count, :tms_compat,
                :level_moves, :evolution_chain

  # The name supplied from user input
  def initialize(name = 'Tangela')
    @name = name
    @id = @height = @weight = @base_experience = @types = @abilities = nil
    @moves = @move_count = nil

    # array to hold all compat tm moves for this pokemon
    @tms_compat = []
    # hash to hold all the moves learned by level
    @level_moves = {}
    # hash to store the evolution chain new_form => trigger
    @evolution_chain = {}
    return if get_pokemon_info

    @@has_stats = false
  end

  # @return false if the query raises an error true if else
  def get_pokemon_info
    # unless Poke_Query returns true; return false from this method
    unless (stats = Poke_Query.get_pokemon_by_name(@name))
      return false
    end

    @id = stats['id']
    @height = stats['height']
    @base_experience = stats['base_experience']
    @types = stats['types']
    @abilities = stats['abilities']
    @moves = stats['moves']
    @move_count = @moves.length
    @@has_stats = true
    true # return true
  end

  def display_abilities
    return false unless @abilities.length.positive?

    @abilities.each { |ability| puts "\t #{ability['ability']['name'].capitalize}" }
  end

  # @return false if @types is empty
  # display this Pokemons type
  def display_types
    return false unless @types.length.positive?

    @types.each { |type| puts "\t #{type['type']['name'].capitalize}" }
  end

  # Extract the moves out to the API calls data struct
  # Store moves that have a level = 0 into the TMs array
  # Store all moves that have a level > 0 into -
  #   a level_moves hash (name=>level) key value

  def store_moves
    return false unless @moves.length.positive?

    @moves.each do |move|
      move_name = move['move']['name'].tr('-', ' ').capitalize
      level = move['version_group_details'][0]['level_learned_at']

      if level.zero? # if level = 0 then it's learned by TM
        @tms_compat.push(move_name) # push onto the tms_Array
      else
        @level_moves[move_name] = level # else it's learned by level up
      end
    end
  end

  # @return [nil]
  def pretty_print
    puts "Error #{@name} doesn't have any stats to display " unless @@has_stats
    puts "Name: #{@name}"
    puts "PokeID: #{@id}"
    puts "Height: #{@height}"
    puts "Weight: #{@weight}"
    puts "Base Experience: #{@base_experience}"
    puts 'Abilities:'
    display_abilities
    puts 'Types:'
    display_types
  end

  def print_moves
    puts "#{@name.capitalize}'s Moves Include: "
    @moves.each do |move|
      puts "- #{move['move']['name']}"
      $x += 1
      break if $x == 5
    end
  end

  def print_move_count
    puts "#{@name.capitalize} can learn #{move_count} #{if @move_count < 2
                                                          'move'
                                                        else
                                                          'moves'
                                                        end}"
    puts "Do you want to see all #{move_count} moves? "
    ans = gets.chomp
    verbose_move_list if ans.upcase == 'Y'
  end

  # the \ in the puts statement prevents the line break
  # anytime a statement needs to run to the next line you must use \ even in
  # assignment statements etc

  def verbose_move_list
    @moves.each do |move|
      move_name = move['move']['name'].tr('-', ' ').capitalize
      level = move['version_group_details'][0]['level_learned_at']

      if level.zero? # if level = 0 then it's learned by TM
        @@TMs_compat.push(move_name) # push onto the tms_Array
      else
        @@level_moves[move_name] = level # else it's learned by level up
      end
    end

    @@level_moves.each { |k, v| puts "#{k} Level: #{v}" }
    @@TMs_compat.each { |tm| puts "TM: #{tm}" }
  end
end

# move["move"]["name"]["version_group_details"]
# the below prints the level each move is learned at from the moves array
#  @moves.each {|move| puts move["version_group_details"][0]["level_learned_at"]
