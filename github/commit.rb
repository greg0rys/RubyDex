#!/usr/bin/ruby
# frozen_string_literal: true


require 'date'
system('clear')
system('echo Creating Rubocop reports..')
d = DateTime.now
PATH = 'reports/'
all_off = "#{d.strftime('%m-%d-%Y-%H:%M')}_all_offenses"
`./cleaners/clean_reports.rb`
system("rubocop -f m -E >> #{PATH}#{all_off}.md")
cop_correctable = "#{d.strftime('%m-%d-%Y-%H:%M')}_cop_fixable"
system("rubocop -f m -E --display-only-correctable >> #{PATH}#{cop_correctable}.md")

puts "Created ~/RubyDex/reports/#{all_off}.md"
puts "Created ~/RubyDex/reports/#{cop_correctable}.md"

puts '-' * 10

puts 'Time to commit'

print 'Enter a commit message: '
msg = gets.chomp
puts
system('sleep 1')
system("git add . && git commit -m '#{msg}' && git push")
system('clear')
system('echo Commit to Origin Master Done')
