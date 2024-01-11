# frozen_string_literal: true

=begin
@author Greg


String_Cleaners contains helper methods to clean various types of strings in the application.
=end

module String_Cleaners
  # Remove the "-" character from a given string
  # @param dash_string - a string that contains a "-" character
  # @return the newly mutated string
  # @note mainly used to clean up Pokemon Moves
  def remove_dash(dash_string)
    # remove the - from move names i.e Chilling-water => Chilling Water
    return false if dash_string.nil?

    dash_string.tr('-', ' ')
  end


end
