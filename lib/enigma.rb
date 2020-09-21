class Enigma
  def initialize
    @character_set = ('a'..'z').to_a << ' '
  end

  def encrypt(message:, key: generate_key, date: todays_date)
    loop_count = 0

    encryption = message.split('').map do |letter|
      if character_set.include?(letter.downcase)
        current_value = character_set.index(letter.downcase)
        new_value = current_value + shifts(key, date).rotate(loop_count).first
        loop_count += 1
        character_set.rotate(new_value).first
      else
        letter
      end
    end

    { encryption: encryption.join, key: key, date: date }
  end

  def decrypt(message:, key: generate_key, date: todays_date)
    loop_count = 0

    decryption = message.split('').map do |letter|
      if character_set.include?(letter.downcase)
        current_value = character_set.index(letter.downcase)
        new_value = current_value - shifts(key, date).rotate(loop_count).first
        loop_count += 1
        character_set.rotate(new_value).first
      else
        letter
      end
    end

    { decryption: decryption.join, key: key, date: date }
  end

  def crack(ciphertext:, date: todays_date)
    shift = [0, 1, 2, 3]
    expected = [' ', 'e', 'n', 'd']
    hash = { A: 0, B: 1, C: 2, D: 3 }
    d = generate_offset(date) 

    chars_in_set = ciphertext.split('').find_all do |char|
      character_set.include?(char)
    end

    index = 0
    loop_count = chars_in_set.count - 5
    
    chars_in_set.last(4).each do |char|
      current_value = character_set.index(char.downcase)
      new_set = character_set.rotate(current_value)
      shift_num = 0
      until char == expected[index]
        char = new_set.rotate(-shift_num).first   
        break if char == expected[index]

        shift_num += 1
      end
      index += 1
      loop_count += 1
      
      case shift.rotate(loop_count).first
      when 0
        hash[:A] = shift_num
      when 1
        hash[:B] = shift_num
      when 2
        hash[:C] = shift_num
      when 3
        hash[:D] = shift_num
      end
    end 
require 'pry'; binding.pry
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
