require './test/test_helper'

class MessengerTest < Minitest::Test
  def setup
    @enigma = Enigma.new
    @writer = Writer.new
    
    @messenger = Messenger.new(@enigma, @writer)
  end

  def test_it_exists
    assert_instance_of Messenger, @messenger
  end
end
