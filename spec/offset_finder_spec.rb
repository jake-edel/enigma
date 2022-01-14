require './lib/offset_finder'

RSpec.describe OffsetFinder do
  before(:each) do
    @key = '02715'
    @date = '040895'
    @encryptor = OffsetFinder.new
  end

  describe '#find_consecutive_values' do
    it 'takes a string as arg and returns an array of consecutive numbers stored in arrays' do
      consecutive_values = OffsetFinder.find_consecutive_values(@key)
      expect(consecutive_values.all? { |cons| cons.to_i.instance_of?(Integer) }).to be true
      expect(consecutive_values).to eq [2, 27, 71, 15]
    end
  end

  describe '#offsets_from_date' do
    it 'takes a string as an arg and returns a calculated offset' do
      offsets = OffsetFinder.offsets_from_date(@date)
      expect(offsets.all? { |value| value.to_i.instance_of?(Integer) }).to be true
      expect(offsets).to eq [1, 0, 2, 5]
    end
  end

  describe '#last_four_of_squared_value' do
    it 'squares a string and strips the last 4 digits of the returned value' do
      last_four = OffsetFinder.last_four_of_squared_value(@date)
      expect(last_four.all? { |value| value.to_i.instance_of?(Integer) }).to be true
      expect(last_four).to eq %w[1 0 2 5]
    end
  end

  describe '#sum_arrays' do
    it 'adds the elements of an array with their corresponding index in another array' do
      a1 = [1, 2, 3, 4]
      a2 = a1.reverse
      expect(OffsetFinder.sum_arrays(a1, a2)).to eq [5, 5, 5, 5]
    end
  end
end
