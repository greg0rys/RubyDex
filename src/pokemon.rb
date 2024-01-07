# frozen_string_literal: true
$x = 0
require 'uri'
require 'net/http'
require 'openssl'
require 'json'
require_relative 'mods/pokequery'

class Pokemon
  attr_accessor :name, :id, :height, :weight, :base_experience, :types,
                :abilities, :moves, :move_count

  def initialize(name)
    @name = name
    get_pokemon_info

  end

  def get_pokemon_info
    uri = URI("https://pokeapi.co/api/v2/pokemon/#{@name}")
    res = Net::HTTP.get_response(uri)
    result = JSON.parse(res.body)
    @height = result["height"]
    @weight = result["weight"]
    @base_experience = result["base_experience"]
    @types = result["types"]
    @abilities = result["abilities"]
    @id = result["id"]
    @moves = result["moves"]
    @move_count = Array(@moves).length

  end

  # @return [nil]
  def pretty_print
    puts "Name: #{@name}"
    puts "PokeID: #{@id}"
    puts "Height: #{@height}"
    puts "Weight: #{@weight}"
    puts "Base Experience: #{@base_experience}"
    puts "Abilities:"
    @abilities.each do |ability| puts "\t #{ability["ability"]["name"]}" end
    puts "Type:"
    @types.each do |type| puts "\t #{type["type"]["name"]}"end

end


  def print_moves
    puts "#{@name.capitalize}'s Moves Include: "
    @moves.each do
    |move| puts "- #{move["move"]["name"]}"; $x += 1; break if $x == 5
    end
  end

  def print_move_count
    puts "#{@name.capitalize} can learn #{move_count} #{@move_count < 2 ?
                                                        "move" : "moves"}"
    puts "Do you want to see all #{move_count} moves? "
    ans = gets.chomp
    verbose_move_list if ans.upcase == "Y"
  end

  # the \ in the puts statement prevents the line break
  # anytime a statement needs to run to the next line you must use \ even in
  # assignment statements etc
def verbose_move_list
  @moves.each do
    | move |


    if move["version_group_details"][0]["level_learned_at"] == 0
      level_learned = 1
    else
      level_learned = move["version_group_details"][0]["level_learned_at"]
    end

    puts "#{move["move"]["name"].capitalize} => Level: \
#{remove_dash(level_learned)}"
  end

end
end




# move["move"]["name"]["version_group_details"]
# the below prints the level each move is learned at from the moves array
#  @moves.each {|move| puts move["version_group_details"][0]["level_learned_at"]