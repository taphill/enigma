require './test/test_helper'

class MessengerTest < Minitest::Test
  def setup
    @enigma = Enigma.new
    @file = './test_message.txt'
    @enrypted_file = './test_encrypted.txt'
    
    @file_manager = FileManager.new(@enigma)
  end

  def test_it_exists
    assert_instance_of FileManager, @file_manager
  end

  def test_it_has_attributes
    assert_instance_of Enigma, @file_manager.enigma
  end

  def test_it_can_receive_enrypted_message_with_key_and_date
    expected = {
      encryption: 'ked$er ohulw!',
      key: '02715',
      date: '040895'
    }

    assert_equal expected, @file_manager.send(:please_encrypt, @file, '02715', '040895')
  end

  def test_it_can_write_file
    file = 'write_file_test.txt'

    @file_manager.send(:write_file, file, 'This is a test!')

    assert_instance_of File, File.open(file, 'r')
  end

  def test_it_can_receive_enrypted_message_with_key_and_todays_date
    @enigma.stubs(:todays_date).returns('190920')

    expected = {
      encryption: 'pib$ wdmczpu!',
      key: '02715',
      date: '190920'
    }

    assert_equal expected, @file_manager.send(:please_encrypt, @file, '02715', nil)
  end

  def test_it_can_receive_enrypted_message_with_random_key_and_todays_date
    @enigma.stubs(:generate_key).returns('30317')
    @enigma.stubs(:todays_date).returns('190920')

    expected = {
      encryption: 'qlp$bxg e sh!',
      key: '30317',
      date: '190920'
    }

    assert_equal expected, @file_manager.send(:please_encrypt, @file, nil, nil)
  end

  def test_it_can_receive_decrypted_message_with_key_and_date
    expected = {
      decryption: 'hello wo%rld!',
      key: '02715',
      date: '040895'
    }

    assert_equal expected, @file_manager.send(:please_decrypt, @enrypted_file, '02715', '040895')
  end

  def test_it_can_receive_decrypted_message_with_key_and_todays_date
    @enigma.stubs(:todays_date).returns('040895')

    expected = {
      decryption: 'hello wo%rld!',
      key: '02715',
      date: '040895'
    }

    assert_equal expected, @file_manager.send(:please_decrypt, @enrypted_file, '02715', nil)
  end
end
