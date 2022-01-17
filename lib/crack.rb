require './lib/key_gen'

class CodeCracker
  def self.crack(message, date = KeyGen.generate_date)
    unencrypted_signature = ' end' # Last 4 chars must always translate to this
    encrypted_signature = message[-4..-1] # Last 4 chars of encrypted message
    # unencrypted_signature <= encrypt/decrypt => encrypted_signature

    @char_set = KeyGen.char_set

    # Assumption: message will follow the same 1,2,3,4 shift pattern, find where in the pattern the ' end' signature is located. #locate_shifts will take message, and return the 'shift_index_pattern' mapped to ' end'

    # In this example, the ' ' is the 4th shift, 'e' is the 1st shift, 'n' is the second shift, 'd' is the third shift. The last four characters of the encrypted message are hssi. So hssi shifted by shifts at index [3, 0, 1, 2] = ' end'. We need to find the sequence of shifts such that 'ssih' with be shifted to 'd en' The difference between each char per index should be a working set of shift values.

    # Encryption
    # shift_index 3:  ' '(char_index 26) shifts to  h(char_index 7) diff 8
    # shift_index 0:  e(char_index 4)   shifts to  s(char_index 18) diff 14
    # shift_index 1:  n(char_index 13) shifts to  s(char_index 18) diff 5
    # shift_index 2:  d(char_index 3)   shifts to    i(char_index 8) diff 5

    # Decryption
    # shift_index 3:  h(char_index 7) shifts to    ' '(char_index 26) diff 19
    # shift_index 0:  s(char_index 18)   shifts to  e(char_index 4) diff 13
    # shift_index 1:  s(char_index 18) shifts to  n(char_index 13) diff 22
    # shift_index 2:  i(char_index 8)   shifts to   d(char_index 3) diff 22
    
    # Does [14, 5, 5, 8] encode 'hello world end' to 'vjqtbeaweqihssi'?
    # Oh hell yeah it does

    shift_index_pattern = locate_shifts(message)

    # Once we've found the shift_pattern, we map each char of ' end' to the pattern to the encrypted signature in a key/value pair.

    char_array = pattern_map(unencrypted_signature, encrypted_signature, shift_index_pattern)
    # Given a hash of unencrypted chars mapped to encrypted chars, we need a method to calculate the number of shifts required to move from unencrypted to encrypted. Returns the shifts out of order
    unsorted_shifts = calculate_shifts(char_array)

    # Need to place shifts back in order
    shifts = rotate_shifts(unsorted_shifts, shift_index_pattern)
    # require 'pry-byebug'; binding.pry
  end

  # method to map and shuffle ' end' signature to the index pattern, regardless of pattern order.
  # Need to drop hash and use array of pairs, Hash will not allow for duplicate key values
  def self.pattern_map(plaintext, encrypted, pattern)
    pt_array = plaintext.split('')
    crypt_array = encrypted.split('')
    char_array = []
    # require 'pry-byebug'; binding.pry
    pattern.each do |index|
      char_array << [pt_array[index], crypt_array[index]]
    end
    char_array
  end

    # How to handle shifts that rotate around to the front of the char set ie. value from line 51 returns negative
  def self.calculate_shifts(char_array)
    unordered_shifts = []
    char_array.each do |pair|
      unordered_shifts << count_shifts(pair.last, pair.first)
    end
    unordered_shifts
  end

  def self.count_shifts(crypt_char, pt_char)
    rotated_char_set = @char_set.rotate(@char_set.index(pt_char))
    count = 0
    until rotated_char_set.first == crypt_char
      rotated_char_set.rotate!
      count += 1
    end
    count
  end

  def self.rotate_shifts(shifts, pattern)
    shifts.rotate(pattern.index(0))
  end

    # How to find the combination of 5 digit key and 6 digit date that resolves to [14, 5, 5, 8]?

    # The shifts are the sum of two arrays.
    # Any of these numbers + 27 should work the same

    # 108= Highest possible value for a shift?

    # Possible shift arrays:

    #     [14, 5, 5, 8]
    #     [41, 32, 32, 35]
    #     [68, 59, 59, 62]
    #     [95, 86, 86, 89]

    # ...or any combination of these numbers

    # 4 ^ 4 = 256 possibilities?Any possibility could be different key / date combo?

    # Brute force every key / date combo to find combination that matches one of these possibilities

    # Given date '291018', what is the key?

    # 291018**2 = 84691476324
    # Last four are 6324

    # Shifts - Digit = Joined pair
    # 14      -  6     = 08
    # 5        -  3     = 02
    # 5        -  2     = 03
    # 8        -  4     = 04

    # Pairs would be 08, 02, 03, 04
    # Not a valid key, each pair must begin with the second digit of the previous one

    # Given key 08304 and date 291018, do we get a valid shift array?

    # Shifts - Digit = Joined pair
    # 14      -  6     = 08
    # 86      -  3     = 83
    # 32      -  2     = 30
    # 8        -  4     = 04

    # Our shift array is [14, 86, 32, 8]

    # How to codify the above logic?
    # How to find the key knowing only the date, and the ' end' signature?
    # How to find the key using todays date?
  def self.locate_shifts(message)
    shift_pattern = []
    message.split('').each_with_index do |char, index|
      next unless index > (message.size - 5)

      shift_pattern << index % 4
      # print "\n#{char}: #{index} ==> #{index % 4}\n"
    end
    shift_pattern
  end
end

# Well I can't say I didn't try...
