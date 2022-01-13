require './lib/encryptor'

RSpec.describe Encryptor do
  before(:each) do
    @key = '12345'
    @date = '130122'
    @encryptor = Encryptor.new
  end

  describe '#find_consecutive_values' do
    it 'takes a string as arg and returns an array of consecutive numbers stored in arrays' do
      consecutive_values = Encryptor.find_consecutive_values(@key)
      expect(consecutive_values.all? { |cons| cons.to_i.instance_of?(Integer) }).to be true
      expect(consecutive_values).to eq [12, 23, 34, 45]
    end
  end

  describe '#offsets_from_date' do
    it 'takes a string as an arg and returns a calculated offset' do
      offsets = Encryptor.offsets_from_date(@date)
      expect(offsets.all? { |value| value.to_i.instance_of?(Integer) }).to be true
      expect(offsets).to eq [4, 8, 8, 4]
    end
  end

  describe '#last_four_of_squared_value' do
    it 'squares a string and strips the last 4 digits of the returned value' do
      last_four = Encryptor.last_four_of_squared_value(@date)
      expect(last_four.all? { |value| value.to_i.instance_of?(Integer) }).to be true
      expect(last_four).to eq ['4', '8', '8', '4']
    end
  end
end
