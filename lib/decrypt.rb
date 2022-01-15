require './lib/enigma'

class Interface < Enigma
  def initialize
    @encryption_file_path = './msgs/' + ARGV.first
    @decryption_file_path = './msgs/' + ARGV[1]
    @key = ARGV[2]
    @date = ARGV.last
    read_message
    decrypt_message
    write_decrypted_message
    print_output
 	end

  def read_message
    File.open(@encryption_file_path, 'rb') do |file|
      @encryption = file.read.chomp
    end
  end

  def decrypt_message
    @decryption_hash = decrypt(@encryption, @key, @date)
    require 'pry-byebug'; binding.pry
  end

  def write_decrypted_message
    File.open(@decryption_file_path, 'wb') do |file|
      file << @decryption_hash[:decryption]
    end
  end

  def print_output
    puts "Created '#{ARGV[1]}' with the key #{@decryption_hash[:key]} and the date #{@decryption_hash[:date]}"
  end
end

unless ARGV.count == 4
  puts 'Incorrect # of Arguments'
  return
end

Interface.new
