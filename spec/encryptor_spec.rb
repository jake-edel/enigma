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
      expect(consecutive_values.all? { |cons| cons.to_i.instance_of?(Integer) }).to be true
      expect(consecutive_values).to eq [12, 23, 34, 45]
    end
  end
end
