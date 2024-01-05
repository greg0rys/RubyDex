# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'openssl'
require 'json'
require_relative 'pokequery'

class Pokemon
  attr_accessor :name, :id, :height, :weight, :base_experience, :types, :abilities

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

end


