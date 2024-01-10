# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'openssl'
require 'json'

module Poke_Query
  # store all of the different queries in a hash
  # this is globally accessible

  $query = {
    'name' => 'https://pokeapi.co/api/v2/pokemon/',
    'number' => 'https://pokeapi.co/api/v2/pokemon/',
    'type' => 'https://pokeapi.co/api/v2/pokemon/'
  }

  def get_pokemon_by_name(name = 'Tangela')
    # let user know we will get data for Tangela since no value supplied
    puts "You did not supply a Pokemon name, using the default #{name}" if name === 'Tangela'

    pokemon_info = run_query(
      'name',
      name
    )
    false # if we reach this line then the res was not the proper length
  end

  def get_pokemon_by_number(number = '1')
    puts "You did not supply a Pokemon number, using the default #{number}" if number === 1

    pokemon_info = run_query(
      'number',
      number
    )

    return pokemon if pokemon.length.positive?

    false # if we reach this no pokemon was returned, and user was alerted
  end

  def run_query(query_type = 'name', query_value = 'Tangela')
    uri = URI("#{$query[query_type]}#{query_value}")
    res = Net::HTTP.get_response(uri)
    return JSON.parse(res.body) if res.body.lenght.positive?

    puts "The response size was #{res.body.length} -- Invalid Response"
    false
  end
end
