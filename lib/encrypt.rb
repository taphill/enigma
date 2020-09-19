require_relative './lib/enigma'
require_relative './lib/writer'
require_relative './lib/messenger'


enigma = Enigma.new
writer = Writer.new
    
messenger = Messenger.new(enigma, writer)

require 'pry'; binding.pry
a = messenger.please_encrypt(ARGV[0])

x = 0
