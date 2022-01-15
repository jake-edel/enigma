require './lib/enigma'

class Interface
  def self.enigma(decrypt: false)
    input_path = './msgs/' + ARGV.first
    output_path = './msgs/' + ARGV[1]
    message = read_message(input_path)
    hash = shift_message(message, decrypt)
    if decrypt
      write_message(output_path, hash[:decryption])
    else
      write_message(output_path, hash[:encryption])
    end
    print_output(hash[:key], hash[:date])
  end

  def self.read_message(file_path)
    File.open(file_path, 'rb') do |file|
      return file.read.chomp
    end
  end

  def self.shift_message(message, decrypt)
    decrypt ? Enigma.decrypt(message, ARGV[2], ARGV.last) : Enigma.encrypt(message)
  end

  def self.write_message(file_path, message)
    File.open(file_path, 'wb') do |file|
      file << message
    end
  end

  def self.print_output(key, date)
    puts "Created '#{ARGV[1]}' with the key #{key} and the date #{date}"
  end
end
