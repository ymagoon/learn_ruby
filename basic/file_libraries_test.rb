require './files_libraries.rb'
require 'net/http'

#puts "This is a test".vowels.join('-')

Net::HTTP.get_print('http://www.rubyinside.com', '/index.html')
