require 'date'

class FileManager
  attr_reader :enigma

  def initialize(enigma)
    @enigma = enigma
  end

  def encrypt_file(file_to_encrypt, new_file, key = nil, date = nil)
    return error_message if please_encrypt(file_to_encrypt, key, date) == error_message

    encryption = please_encrypt(file_to_encrypt, key, date)
    write_file(new_file, encryption[:encryption])

    "Created '#{new_file}' with the key #{encryption[:key]} and date #{encryption[:date]}"
  end

  def decrypt_file(file_to_decrypt, new_file, key = nil, date = nil)
    return error_message if please_decrypt(file_to_decrypt, key, date) == error_message

    decryption = please_decrypt(file_to_decrypt, key, date)
    write_file(new_file, decryption[:decryption])
    
    "Created '#{new_file}' with the key #{decryption[:key]} and date #{decryption[:date]}"
  end

  private

  def please_encrypt(file_to_encrypt, key, date)
    file = File.open(file_to_encrypt, 'r')

    return enigma.encrypt(message: file.read, key: key, date: date) if key_valid?(key) && date_valid?(date)
    return enigma.encrypt(message: file.read, key: key) if key_valid?(key)
    return enigma.encrypt(message: file.read) if key.nil? && date.nil?

    error_message
  end

  def please_decrypt(file_to_decrypt, key, date)
    file = File.open(file_to_decrypt, 'r')

    return enigma.decrypt(message: file.read, key: key, date: date) if key_valid?(key) && date_valid?(date)
    return enigma.decrypt(message: file.read, key: key) if key_valid?(key)
    return enigma.decrypt(message: file.read) if key.nil? && date.nil?

    error_message
  end

  def write_file(file, message)
    new_file = File.open(file, 'w')

    new_file.write(message)
  end

  def key_valid?(key)
    key.length == 5
  end

  def date_valid?(date)
    return false unless date.is_a? String

    date_array = date.scan(/../)
    Date.valid_date?(date_array[2].to_i, date_array[1].to_i, date_array[0].to_i)
  end

  def error_message
    "ERROR: Either the key or date entered is invalid.
       Please enter a 5 digit number for the key and a valid date in this format DDMMYY"
  end
end
