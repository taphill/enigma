require_relative './lib/enigma'
require_relative './lib/writer'
require_relative './lib/messenger'


enigma = Enigma.new
writer = Writer.new
    
messenger = Messenger.new(enigma, writer)

x = 0
