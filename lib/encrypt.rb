require './lib/enigma'

class Interface < Enigma
  def initialize
    @message_file_path = './msgs/' + ARGV.first
    @encryption_file_path = './msgs/' + ARGV[1]
    read_message
    encrypt_message
    write_encrypted_message
    print_output
 	end

  def read_message
    File.open(@message_file_path, 'rb') do |file|
      @plain_text = file.read.chomp
    end
  end

  def encrypt_message
    @encryption_hash = encrypt(@plain_text)
  end

  def write_encrypted_message
    File.open(@encryption_file_path, 'wb') do |file|
      file << @encryption_hash
    end
  end

  def print_output
    puts "Created '#{ARGV.first}' with the key #{@encryption_hash[:key]} and the date #{@encryption_hash[:date]}"
  end
end

Interface.new
