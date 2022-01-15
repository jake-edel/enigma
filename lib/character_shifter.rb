class CharacterShifter
  def initialize(message, offsets)
    @message = message
    @offsets = offsets
    @char_set = (("a".."z").to_a << ' ')
  end

    def shift_message
      encrypted_message = ''
      @message.downcase.each_char do |char|
        if @char_set.include?(char)
          encrypted_message += shift_char(char, @offsets.first)
          @offsets.rotate!
        else
          encrypted_message += char
        end
      end
      encrypted_message
    end

    def shift_char(char, shift)
      shift = (@char_set.index(char) + shift) % @char_set.size
      @char_set[shift]
    end
end
