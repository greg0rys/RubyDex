=begin
@author Greg
@date 01/10/2023
=end
require 'json'
include String_Cleaners

module Driver

    attr :runs
    def start
        @runs = true
    end
        while @runs
            display_menu
            @runs = continue?
    end
end