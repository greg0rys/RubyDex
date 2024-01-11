# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'openssl'
require 'json'


module Poke_Query
  # store all of the different queries in a hash
  # this is globally accessible

  $endpoint = {
    'name'   => 'https://pokeapi.co/api/v2/pokemon/',
    'number' => 'https://pokeapi.co/api/v2/pokemon/',
    'type'   => 'https://pokeapi.co/api/v2/pokemon/',
    'machine' => 'https://pokeapi.co/api/v2/machine/',
    'move' => 'https://pokeapi.co/api/v2/move/'
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

    # return the query results to the caller
    run_query(
      'number',
      number
    )

  end

  #@param query_type - the type of query being ran
  def run_query(query_type = 'name', query_value = 'Tangela')

    begin
      puts "Querying endpoint #{query_type}"
      uri = URI("#{$endpoint[query_type]}#{query_value}")
      res = Net::HTTP.get_response(uri)
      puts "Query complete... Checking for valid response"
      return JSON.parse(res.body) if res.body.length.positive?

      raise JSON::ParserError

    rescue

      puts "#{res.code} -- ERROR"

      return false
    end

  end

end
