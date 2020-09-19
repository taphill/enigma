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

  def test_it_has_attributes
    assert_instance_of Enigma, @messenger.enigma
    assert_instance_of Writer, @messenger.writer
  end
end
