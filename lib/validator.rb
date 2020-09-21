module Validator
  require 'date'

  def valid_key_and_date?(key, date)
    key_valid?(key) && date_valid?(date)
  end

  def key_valid?(key)
    return false unless key.is_a?(String)

    key.length == 5
  end

  def date_valid?(date)
    return false unless date.is_a?(String) && date.length == 6

    date_array = date.scan(/../)
    Date.valid_date?(date_array[2].to_i, date_array[1].to_i, date_array[0].to_i)
  end

  def encryption_error?(file_to_encrypt, key, date)
    please_encrypt(file_to_encrypt, key, date) == key_date_error_message
  end

  def decryption_error?(file_to_decrypt, key, date)
    please_decrypt(file_to_decrypt, key, date) == key_date_error_message
  end

  def crack_error?(file_to_crack, date)
    please_crack(file_to_crack, date) == crack_error_message
  end

  def file_error?(file_read, file_write)
    return true if file_read.nil? || file_write.nil?

    if file_read.split('').last(4).join == '.txt' && file_write.split('').last(4).join == '.txt'
      false
    else
      true
    end
  end

  def key_date_error_message
    "ERROR: Either the key or date entered is invalid.
       Please enter a 5 digit number for the key and a valid date in this format DDMMYY"
  end

  def file_error_message
    'ERROR: Make sure you enter a .txt file to read from AND a .txt file to write to'
  end

  def crack_error_message
    "ERROR: You entered a date, but it is invalid.
       If you would like to enter a date, please make sure it is a valid date in this format DDMMYY"
  end
end
