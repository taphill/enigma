require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/enigma'

class EnigmaTest < Minitest::Test
  def test_it_exists
    enigma = Enigma.new

    assert_instance_of Enigma, enigma
  end

  def test_it_can_generate_a_key
    skip
    enigma = Enigma.new

    # enigma.expects(:rand(0)).times(5)

    # WIP
  end

  def test_it_can_return_todays_date
    enigma = Enigma.new

    date = Time.now.strftime("%d/%m/%y").delete('/')

    assert_equal date, enigma.todays_date
  end
end
