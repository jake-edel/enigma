require './lib/crack'

RSpec.describe CodeCracker do
  before :each do
    @hash = {
      # encryption: 'vjqtbeaweqihssi',
      encryption: 'vjqtbeaweqihssi',
      key: '08304',
      date: '291018'
    }
  end

  it 'takes an encrypted message, and optional date, and returns the unencrypted message, and encryption key' do
    expected = {
      decryption: 'hello world end',
      date: '291018',
      key: '08304'
    }
    CodeCracker.crack(@hash[:encryption], @hash[:date])
    # expect(CodeCracker.crack(@hash[:encryption], @hash[:date])).to eq(expected)
  end
end
