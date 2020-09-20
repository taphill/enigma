require_relative '../lib/enigma'
require_relative '../lib/file_manager'

enigma = Enigma.new
file_manager = FileManager.new(enigma)

message = file_manager.encrypt_file(ARGV[0], ARGV[1], ARGV[2], ARGV[3])

puts message
