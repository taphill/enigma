class Enigma
  attr_reader :character_set

  def initialize
    @character_set = ('a'..'z').to_a << ' '
  end

  def encrypt(message, key = generate_key, date = todays_date)

  end

  def generate_key
    5.times.map { rand(0..9) }.join
  end

  def generate_offset(date)
    offset = date.to_i**2

    offset.to_s.chars.last(4).join
  end

  def todays_date
    Time.now.strftime('%d/%m/%y').delete('/')
  end

  def a_shift(key, date)
    key[0..1].to_i + generate_offset(date)[0].to_i
  end

  def b_shift(key, date)
    key[1..2].to_i + generate_offset(date)[1].to_i
  end

  def c_shift(key, date)
    key[2..3].to_i + generate_offset(date)[2].to_i
  end

  def d_shift(key, date)
    key[3..4].to_i + generate_offset(date)[3].to_i
  end
end
