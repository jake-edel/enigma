require './lib/enigma'

RSpec.describe Enigma do
  before(:each) do
    message = 'Hello World',
    key = '02715',
    date = '040895'
    ciphertext = 'Keder Ohulw'

    @encrypted = Enigma.encrypt(message, key, date)
    @decrypted = Enigma.decrypt(ciphertext, key, date)
  end

  it 'takes a hash with a string, a key, and a date, encrypts message, and returns a hash with an encryped string, key, and date' do
    expect(@encrypted).to be_instance_of Hash
  end

  it 'takes a hash with an encrypted cipher text, an decryption key, and decryption date, and returns a hash with a decrypted message, key and date' do
    require 'pry-byebug'; binding.pry
    expect(@decrypted).to be_instance_of Hash
  end
 end
