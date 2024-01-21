#!/usr/bin/ruby
# frozen_string_literal: true

count = `ls -1 ../reports | wc -l`.to_i

if count >= 4
  puts "Cleaning up removing #{count} reports"
  `rm -v ../reports/*.md`
end
