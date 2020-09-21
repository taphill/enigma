module Cracked
  def crack(ciphertext:, date: todays_date)
    shift = [0, 1, 2, 3]
    expected = [' ', 'e', 'n', 'd']
    hash = { A: 0, B: 1, C: 2, D: 3 }

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

    check_shift(ciphertext, hash, date)
  end

  def check_shift(ciphertext, shift, date)
    offset = generate_offset(date)

    a_init = (shift[:A].to_i - offset[0].to_i).to_s
    b_init = (shift[:B].to_i - offset[1].to_i).to_s
    c_init = (shift[:C].to_i - offset[2].to_i).to_s
    d_init = (shift[:D].to_i - offset[3].to_i).to_s

    shifts = [a_init, b_init, c_init, d_init]
    shifts.map! do |num|
      num = (num.to_i + 27).to_s if num.to_i < 0

      if num.to_i.digits.count < 2
        num = "%02d" % num
      else
        num
      end
    end
    
    a = shifts[0]
    b = shifts[1]
    c = shifts[2]
    d = shifts[3]

    until a[1] == b[0] && b[1] == c[0] && c[1] == d[0]
      until a[1] == b[0]
        b = (b.to_i + 27).to_s
        if b.to_i > 108
          a = (a.to_i + 27).to_s
          b = shifts[1]
        end
      end

      until b[1] == c[0]
        c = (c.to_i + 27).to_s
        if c.to_i > 108
          a = (a.to_i + 27).to_s
          b = shifts[1]
          c = shifts[2]
          break
        end
      end

      until c[1] == d[0]
        d = (d.to_i + 27).to_s
        if d.to_i > 108
          b = shifts[1]
          c = shifts[2]
          d = shifts[3]
          break
        end
      end
    end

    key = [a[0], b[0], c[0], d].join

    decrypt(message: ciphertext, key: key, date: date)
  end
end
