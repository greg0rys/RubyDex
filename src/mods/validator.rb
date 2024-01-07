# frozen_string_literal: true

module Validator

  # ensure that a given string _s is not empty or nil before using it as any -
  # args
  def is_valid_string(_s)
    if _s == "" || _s.nil?
      return false
    end

    true
  end
end
