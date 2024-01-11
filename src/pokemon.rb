# frozen_string_literal: true

$x = 0
require 'uri'
require 'net/http'
require 'openssl'
require 'json'
require_relative 'mods/pokequery'
include Poke_Query

class Pokemon
  attr_accessor :name, :id, :height, :weight, :base_experience, :types,
                :abilities, :moves, :move_count
  # The name supplied from user input
  def initialize(name = 'Tangela')
    @name = name
    get_pokemon_info
  end

  # init a new Pokemon object by passing in the result array from the API call
  # this type of Pokemon is not created by user input - rather being loaded from some source that
  # contains all of the needed values that define a Pokemon.
  def self.create(*stats)
    @name = stats["name"]
    @id = stats["id"]
    @height = stats["height"]
    @base_experience = stats['base_experience']
    @types = stats['types']
    @abilities = stats['abilities']
    @moves = stats['moves']
    @move_count = Array(@moves).length
  end

  def get_pokemon_info
    stats = Poke_Query::get_pokemon_by_name(@name) # -> array
    @id = stats["id"]
    @height = stats['height']
    @base_experience = stats['base_experience']
    @types = stats['types']
    @abilities = stats['abilities']
    @moves = stats['moves']
    @move_count = Array(@moves).length
  end

  # @return [nil]
  def pretty_print
    puts "Name: #{@name}"
    puts "PokeID: #{@id}"
    puts "Height: #{@height}"
    puts "Weight: #{@weight}"
    puts "Base Experience: #{@base_experience}"
    puts 'Abilities:'
    @abilities.each { |ability| puts "\t #{ability['ability']['name']}" }
    puts 'Type:'
    @types.each { |type| puts "\t #{type['type']['name']}" }
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
      level_learned = if (move['version_group_details'][0]['level_learned_at']).zero?
                        1
                      else
                        move['version_group_details'][0]['level_learned_at']
                      end

      puts "#{move['move']['name'].tr('-', ' ').capitalize} => Level: \
#{level_learned}".rjust(10)
    end
  end


end

# move["move"]["name"]["version_group_details"]
# the below prints the level each move is learned at from the moves array
#  @moves.each {|move| puts move["version_group_details"][0]["level_learned_at"]
