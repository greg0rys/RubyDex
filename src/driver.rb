# frozen_string_literal: true

# @author Greg
# @date 01/10/2023
require 'json'
include String_Cleaners

module Driver
  attr_reader :runs

  def start
    @runs = true
  end
  while @runs
    display_menu
    @runs = continue?
  end
end
