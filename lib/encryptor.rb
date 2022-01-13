class Encryptor

  def self.find_shifts(key, date)
    keys = find_consecutive_values(key)
    offsets = offsets_from_date(date)
  end

  def self.find_consecutive_values(string)
    string.chars.each_cons(2).map { |cons| cons.join('').to_i }
  end

  def self.offsets_from_date(string)
    (string.to_i ** 2).to_s[-4..-1].split('').map(&:to_i)
  end
end
