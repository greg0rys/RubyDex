# frozen_string_literal: true

require 'date'
d = DateTime.now
PATH = "reports/"
all_off = "#{d.strftime('%m-%d-%Y-%H:%M')}_all_offenses"
system("rubocop -f m -E >> reports/#{all_off}.md")
cop_correctable = "#{d.strftime('%m-%d-%Y-%H:%M')}_cop_fixable"
system("rubocop -f m -E --display-only-correctable >> reports/#{cop_correctable}.md")

puts "Created reports/#{all_off}.md"
puts "Created reports/#{cop_correctable}.md"

puts 'Time to commit'

puts 'Enter your commit message'
system("sleep 4")
system("git add . && git commit && git push")

