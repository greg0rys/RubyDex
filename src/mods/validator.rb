# frozen_string_literal: true

module Validator
  # ensure that a given string _s is not empty or nil before using it as any -
  # args
  def is_valid_string(_s)
    return false if _s == '' || _s.nil?

    true
  end

  def valid_pokeno(pokeno)
    # return false if the given pokeno isn't in range 1 => 1025
    return false unless pokeno in 1..1025

    true
  end

  # ensure that the user is supplying a valid menu choice
  # @param menu_choice - the choice the user supplied
  # @returns true if valid false if else
  def valid_menu_choice(menu_choice)
    # if menu choice is not between 1 & 10 invalid choice submitted
    return false unless menu_choice in 1..10

    true # return true
  end
end
