# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'openssl'
require 'json'

class POKEQUERY

  attr_accessor :name, :number, :type, :query

  def initalize(*args)
    @name =   args[0] === nil ? nil : args[0]
    @number = args[1] === nil ? nil : args[1]
    @type =   args[2] === nil ? nil : args[2]
    # store all of the different queries in a hash
    $query = {
      "name" => "https://pokeapi.co/api/v2/pokemon/#{@name}",
      "number" => "https://pokeapi.co/api/v2/pokemon/#{@number}",
      "type" => "https://pokeapi.co/api/v2/pokemon/#{@type}"
    }

  end

  def get_pokemon_by_name
    uri = URI("https://pokeapi.co/api/v2/pokemon/#{@name}")
    res = Net::HTTP.get_response(uri)

    JSON.parse(res.body)
  end

  def get_pokemon_by_number(number)

  end

end
