#!/usr/bin/env ruby

require 'active_support/core_ext'

puts '--- DEPRECATED WARNING ---'
p ActiveSupport::Multibyte::Unicode.downcase('À')
p ActiveSupport::Multibyte::Unicode.upcase('à')
p ActiveSupport::Multibyte::Unicode.swapcase('àÀ')

puts '--- NO DEPRECATED WARNING ---'
p 'À'.downcase
p 'à'.upcase
p 'Àà'.swapcase
