require './test/test_helper'

class MessengerTest < Minitest::Test
  def setup
    @enigma = Enigma.new
    @file = './test_message.txt'
    @stable_file = './dont_change.txt'
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

    assert_equal expected, @file_manager.send(:please_decrypt, @stable_file, '02715', '040895')
  end

  def test_it_can_receive_decrypted_message_with_key_and_todays_date
    @enigma.stubs(:todays_date).returns('040895')

    expected = {
      decryption: 'hello wo%rld!',
      key: '02715',
      date: '040895'
    }

    assert_equal expected, @file_manager.send(:please_decrypt, @stable_file, '02715', nil)
  end

  def test_encrypt_file_can_return_error_message
    expected = "ERROR: Either the key or date entered is invalid.
       Please enter a 5 digit number for the key and a valid date in this format DDMMYY"

    assert_equal expected, @file_manager.encrypt_file(@file, @enrypted_file, '44')
  end

  def test_user_must_provide_key_for_decryption
    expected = 'ERROR: You must enter a key to decrypt a message'

    assert_equal expected, @file_manager.decrypt_file(@file, @enrypted_file)
  end

  def test_decrypt_file_can_return_error_message
    expected = "ERROR: Either the key or date entered is invalid.
       Please enter a 5 digit number for the key and a valid date in this format DDMMYY"

    assert_equal expected, @file_manager.decrypt_file(@file, @enrypted_file, '44')
  end

  def test_it_can_encrypt_file_with_key_and_date
    expected = "Created 'encrypted.txt' with the key 02715 and date 040895"

    assert_equal expected, @file_manager.encrypt_file(@file, 'encrypted.txt', '02715', '040895')
  end

  def test_it_can_encrypt_file_with_key_and_todays_date
    @enigma.stubs(:todays_date).returns('190920')

    expected = "Created 'encrypted.txt' with the key 02715 and date 190920"

    assert_equal expected, @file_manager.encrypt_file(@file, 'encrypted.txt', '02715')
  end

  def test_it_can_ncrypt_file_with_random_key_and_todays_date
    @enigma.stubs(:generate_key).returns('30317')
    @enigma.stubs(:todays_date).returns('190920')

    expected = "Created 'encrypted.txt' with the key 30317 and date 190920"

    assert_equal expected, @file_manager.encrypt_file(@file, 'encrypted.txt')
  end

  def test_it_can_decrypt_file_with_key_and_date
    expected = "Created 'decrypted.txt' with the key 82648 and date 240818"

    assert_equal expected, @file_manager.decrypt_file('encrypted.txt', 'decrypted.txt', '82648', '240818')
  end

  def test_it_can_decrypt_file_with_key_and_todays_date
    @enigma.stubs(:todays_date).returns('190920')

    expected = "Created 'decrypted.txt' with the key 82648 and date 190920"

    assert_equal expected, @file_manager.decrypt_file('encrypted.txt', 'decrypted.txt', '82648', '190920')
  end
end
