# frozen_string_literal: true

# Clean up API Query Results for easy reading through-out the program
module QueryHelper
  def clean_chain(chain_query)
    evolution_hash = {}

    chain_query.each do |evolution|
      evolution_name =    evolution['name'].capitalize
      evolution_trigger = evolution['name'][1]['trigger']
      evolution_hash[evolution_name] = evolution_trigger
    end

    return false unless evolution_hash.length.positive?

    true
  end

end
