# frozen_string_literal: true

module String_Cleaners
  def remove_dash(dash_string)
    # remove the - from move names i.e Chilling-water => Chilling Water
    return false if dash_string.nil?

    dash_string.tr('-', ' ')
  end
end
