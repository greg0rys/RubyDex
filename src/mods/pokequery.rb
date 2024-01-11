# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'openssl'
require 'json'


module Poke_Query
  # store all of the different queries in a hash
  # this is globally accessible

  $query = {
    'name'   => 'https://pokeapi.co/api/v2/pokemon/',
    'number' => 'https://pokeapi.co/api/v2/pokemon/',
    'type'   => 'https://pokeapi.co/api/v2/pokemon/'
  }

  def get_pokemon_by_name(name = 'Tangela')
    # let user know we will get data for Tangela since no value supplied
    puts "You did not supply a Pokemon name, using the default #{name}" if name === 'Tangela'

    # if the info returns false exit
    unless (pokemon_info = run_query(
      'name',
      name
    ))
      return false
    end

    # if we return this then the unless statement evaluated to true
    pokemon_info
  end

  def get_pokemon_by_number(number = '1')

    # return false unless valid_pokeno returns true
    return false unless Validator::valid_pokeno(number)
    puts "You did not supply a Pokemon number, using the default #{number}" if number === 1

    pokemon_info = run_query(
      'number',
      number
    )

    return pokemon_info if pokemon_info.length.positive?

    false # if we reach this no pokemon was returned, and user was alerted
  end

  def run_query(query_type = 'name', query_value = 'Tangela')
    uri = URI("#{$query[query_type]}#{query_value}")
    res = Net::HTTP.get_response(uri)
    return JSON.parse(res.body) if res.body.length.positive?

    puts "#{res.code} -- Invalid Response"
    false
  end

end
