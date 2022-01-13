require './lib/encryptor'

RSpec.describe Encryptor do
  describe '#find_consecutive_values' do
    before(:each) do
      @key = '12345'
      @date = '130122'
      @encryptor = Encryptor.new
    end

    it 'takes a string as arg and returns an array of consecutive numbers stored in arrays' do
      consecutive_values = Encryptor.find_consecutive_values(@key)
      expect(consecutive_values).to eq [ ['1', '2'], ['2', '3'], ['3', '4'], ['4', '5'] ]
    end
  end
 end
