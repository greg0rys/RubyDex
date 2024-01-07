# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'openssl'
require 'json'

module Poke_Query
  # store all of the different queries in a hash
  $query = {
    "name" => "https://pokeapi.co/api/v2/pokemon/",
    "number" => "https://pokeapi.co/api/v2/pokemon/",
    "type" => "https://pokeapi.co/api/v2/pokemon/"
  }

  def get_pokemon_by_name(name)

    if is_valid_string(name)
      uri = URI("#{$query["name"]}/name")
      res = Net::HTTP.get_response(uri)
      return JSON.parse(res.body) || nil if 0 >= res.length
    end

    "The name you entered was #{name.nil? ? "nil " : "empty "} causing it to
return invalid inputs.. try again!"
  end

  def get_pokemon_by_number(number)

    if number <= 0 || number > 1025 || number.nil?
      "#{number} is not a valid Pokemon please enter a number
               \n\tbetween 001 & 1025 (inclusive)"
    end

    uri = URI("#{$query["number"]}/number")
    res = Net::HTTP.get_response(uri)
    JSON.parse(res.body) || nil if 0 >= res.length

  end

  def get_pokemon_by_type(type)
    uri = URI("#{$query["type"]/type}")
  end
  def make_move_hash
    result = Pokemon.new(nil)
  end

end
