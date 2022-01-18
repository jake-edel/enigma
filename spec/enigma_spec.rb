require './lib/enigma'

RSpec.describe Enigma do
  before(:each) do
    @message = 'Hello World'
    @cipher_text = 'keder ohulw'
    key = '02715'
    date = '040895'
    enigma = Enigma.new
    @encrypted = enigma.encrypt(@message, key, date)
    @decrypted = enigma.decrypt(@cipher_text, key, date)
  end

  it 'takes a hash with a string, a key, and a date, encrypts message, and returns a hash with an encryped string, key, and date' do
    expect(@encrypted).to be_instance_of Hash
    expect(@encrypted[:encryption]).to eq @cipher_text
  end

  it 'takes a hash with an encrypted cipher text, an decryption key, and decryption date, and returns a hash with a decrypted message, key and date' do
    expect(@decrypted).to be_instance_of Hash
    expect(@decrypted[:decryption]).to eq @message.downcase
  end
end
