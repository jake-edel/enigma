class Encryptor

  def self.find_shifts(key, date)
    consec_keys = find_consecutive_values(key)

  end

  def self.find_consecutive_values(string)
    consecutive_values = []
    string.chars.each_cons(2) { |cons| consecutive_values << cons.join('') }
    consecutive_values
  end
end