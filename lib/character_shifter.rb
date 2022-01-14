class CharacterShifter
  def initialize(message, offsets)
    @message = message
    @offsets = offsets
    @char_set = (("a".."z").to_a << ' ')
  end

    def shift_message
      @message.each_char do |char|
        p char
      end
    end

    def shift_char(char, shift_value)
    end
end
