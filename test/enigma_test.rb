require './test/test_helper'

class EnigmaTest < Minitest::Test
  def test_it_exists
    enigma = Enigma.new

    assert_instance_of Enigma, enigma
  end

  def test_it_can_create_character_set
    enigma = Enigma.new

    expected = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i',
                'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r',
                's', 't', 'u', 'v', 'w', 'x', 'y', 'z', ' ']

    assert_equal expected, enigma.send(:character_set)
  end

  def test_it_can_return_todays_date
    enigma = Enigma.new

    date = Time.now.strftime('%d/%m/%y').delete('/')

    assert_equal date, enigma.send(:todays_date)
  end

  def test_it_can_generate_a_key
    enigma = Enigma.new

    enigma.expects(:rand).times(5).then.returns(4)

    assert_equal '44444', enigma.send(:generate_key)
  end

  def test_it_can_generate_offset
    enigma = Enigma.new

    date = '040895'

    assert_equal '1025', enigma.send(:generate_offset, date)
  end

  def test_it_can_find_shifts
    enigma = Enigma.new

    key  = '02715'
    date = '040895'

    assert_equal 3, enigma.send(:a_shift, key, date)
    assert_equal 27, enigma.send(:b_shift, key, date)
    assert_equal 73, enigma.send(:c_shift, key, date)
    assert_equal 20, enigma.send(:d_shift, key, date)

    assert_equal [3, 27, 73, 20], enigma.send(:shifts, key, date)
  end

  def test_it_can_encrypt_message_with_key_and_date
    enigma = Enigma.new

    expected = {
      encryption: 'ked$er ohulw!',
      key: '02715',
      date: '040895'
    }

    assert_equal expected, enigma.encrypt(message: 'hel$lo world!', key: '02715', date: '040895')
  end

  def test_it_can_encrypt_message_with_key_and_todays_date
    enigma = Enigma.new

    enigma.stubs(:todays_date).returns('190920')

    expected = {
      encryption: 'pib$ wdmczpu!',
      key: '02715',
      date: '190920'
    }

    assert_equal expected, enigma.encrypt(message: 'hel$lo world!', key: '02715')
  end

  def test_it_can_encrypt_message_wth_random_key_and_todays_date
    enigma = Enigma.new

    enigma.stubs(:generate_key).returns('30317')
    enigma.stubs(:todays_date).returns('190920')

    expected = {
      encryption: 'qlp$bxg e sh!',
      key: '30317',
      date: '190920'
    }

    assert_equal expected, enigma.encrypt(message: 'hel$lo world!')
  end

  def test_it_can_decrypt_message_with_key_and_date
    enigma = Enigma.new

    expected = {
      decryption: 'hello wo%rld!',
      key: '02715',
      date: '040895'
    }

    assert_equal expected, enigma.decrypt(message: 'keder oh%ulw!', key: '02715', date: '040895')
  end

  def test_it_can_decrypt_message_with_random_key_and_todays_date
    enigma = Enigma.new

    enigma.stubs(:todays_date).returns('040895')

    encrypted = {
      encryption: 'keder oh%ulw!',
      key: '02715',
      date: '040895'
    }

    expected = {
      decryption: 'hello wo%rld!',
      key: '02715',
      date: '040895'
    }

    assert_equal expected, enigma.decrypt(message: encrypted[:encryption], key: '02715')
  end

  def test_it_can_crack_message_with_date
    enigma = Enigma.new

    expected = {
      decryption: "!@hello world end",
      date: "291018",
      key: "86799"
    }

    assert_equal expected, enigma.crack(ciphertext: '!@sulgzpwjbadvpcd', date: '291018')
  end

  def test_it_can_crack_message_with_todays_date
    enigma = Enigma.new

    enigma.stubs(:todays_date).returns('291018')

    expected = {
      decryption: "!@hello world end",
      date: "291018",
      key: "86799"
    }

    assert_equal expected, enigma.crack(ciphertext: '!@sulgzpwjbadvpcd')
  end
end
