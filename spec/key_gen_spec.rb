require './lib/key_gen'

 RSpec.describe KeyGen do
  it 'can generate a 5 digit string' do
    1000.times do
      key = KeyGen.generate_key
      expect(key.size).to be 5
      key.each_char do |digit|
        expect(digit.to_i).to be_a Integer
      end
    end
  end

  it 'can generate a 6 digit string from a date' do
    date_key = KeyGen.generate_date
    expect(date_key.size).to be 6
    date_key.each_char do |digit|
      expect(digit.to_i).to be_a Integer
    end
  end
 end
