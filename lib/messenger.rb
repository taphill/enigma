class FileManager 
  attr_reader :enigma, :writer 

  def initialize(enigma)
    @enigma = enigma
  end

  def encrypt_file(file_to_encrypt, new_file, key = nil, date = nil)
    return "ERROR: Invalid key" unless key.nil? && date.nil?

    encryption = please_encrypt(file_to_encrypt)
    file = write_file(new_file, encryption[:encryption])

    "Created '#{new_file}' with the key #{encryption[:key]} and date #{encryption[:date]}"
  end

  private

  def please_encrypt(file_to_encrypt)
    file = File.open(file_to_encrypt, 'r')
    
    enigma.encrypt(file.read)    
  end

  def write_file(file, message)
    new_file = File.open(file, "w")

    new_file.write(message) 
  end
end
