class Enigma
  def initialize
    @character_set = ('a'..'z').to_a << ' '
  end

  def encrypt(message, key = generate_key, date = todays_date)
    loop_count = 0

    encryption = message.split('').map do |letter|
      return letter unless character_set.include?(letter.downcase)

      current_value = character_set.index(letter.downcase)
      new_value = current_value + shifts(key, date).rotate(loop_count).first
      loop_count += 1
      character_set.rotate(new_value).first
    end

    { encryption: encryption.join, key: key, date: date }
  end

  def decrypt(message, key = generate_key, date = todays_date)
    loop_count = 0

    decryption = message.split('').map do |letter|
      return letter unless character_set.include?(letter.downcase)

      current_value = character_set.index(letter.downcase)
      new_value = current_value - shifts(key, date).rotate(loop_count).first
      loop_count += 1
      character_set.rotate(new_value).first
    end

    { decryption: decryption.join, key: key, date: date }
  end

  private

  attr_reader :character_set

  def todays_date
    Time.now.strftime('%d/%m/%y').delete('/')
  end

  def generate_key
    5.times.map { rand(0..9) }.join
  end

  def generate_offset(date)
    offset = date.to_i**2

    offset.to_s.chars.last(4).join
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

  def shifts(key, date)
    shifts = []
    shifts << a_shift(key, date)
    shifts << b_shift(key, date)
    shifts << c_shift(key, date)
    shifts << d_shift(key, date)

    shifts
  end
end
