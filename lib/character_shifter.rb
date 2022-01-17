require './lib/key_gen'

class CharacterShifter
  def initialize(message, offsets)
    @message = message
    @offsets = offsets
    @char_set = KeyGen.char_set
  end

    def shift_message(decrypt = false)
      encrypted_message = ''
      @message.downcase.each_char do |char|
        if @char_set.include?(char)
          encrypted_message += shift_char(char, @offsets.first, decrypt)
          @offsets.rotate!
        else
          encrypted_message += char
        end
      end
      encrypted_message
    end

    def shift_char(char, shift, decrypt = false)
      shift_total = decrypt ? @char_set.index(char) - shift : @char_set.index(char) + shift
      shift = shift_total % @char_set.size
      @char_set[shift]
    end
end
