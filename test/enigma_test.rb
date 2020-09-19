require './test/test_helper'

class EnigmaTest < Minitest::Test
  def test_it_exists
    enigma = Enigma.new

    assert_instance_of Enigma, enigma
  end

  def test_it_can_generate_a_key
    skip
    # enigma = Enigma.new

    # enigma.expects(:rand(0)).times(5)

    # WIP
  end

  def test_it_can_create_character_set
    enigma = Enigma.new

    expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i",
                "j", "k", "l", "m", "n", "o", "p", "q", "r",
                "s", "t", "u", "v", "w", "x", "y", "z", " "]

    assert_equal expected, enigma.send(:character_set)
  end

  def test_it_can_return_todays_date
    enigma = Enigma.new

    date = Time.now.strftime('%d/%m/%y').delete('/')

    assert_equal date, enigma.send(:todays_date)
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

    assert_equal expected, enigma.encrypt('hel$lo world!', '02715', '040895')
  end

  def test_it_can_decrypt_message_with_key_and_date
    enigma = Enigma.new

    expected = {
     decryption: 'hello wo%rld!',
     key: '02715',
     date: '040895'
    }

    assert_equal expected, enigma.decrypt("keder oh%ulw!", "02715", "040895")
  end
end
