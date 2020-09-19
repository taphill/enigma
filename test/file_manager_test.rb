require './test/test_helper'

class MessengerTest < Minitest::Test
  def setup
    @enigma = Enigma.new
    
    @file_manager = FileManager.new(@enigma)
  end

  def test_it_exists
    assert_instance_of FileManager, @file_manager
  end

  def test_it_has_attributes
    assert_instance_of Enigma, @file_manager.enigma
  end
end
