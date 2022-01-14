class OffsetFinder
  def self.find_shifts(key, date)
    keys = find_consecutive_values(key)
    offsets = offsets_from_date(date)

    shifts = sum_arrays(keys, offsets)
  end

  def self.find_consecutive_values(string)
    string.chars.each_cons(2).map { |cons| cons.join('').to_i }
  end

  def self.offsets_from_date(string)
    last_four_of_squared_value(string).map(&:to_i)
  end

  def self.last_four_of_squared_value(string)
    (string.to_i**2).to_s[-4..-1].split('')
  end

  def self.sum_arrays(array1, array2)
    array1.zip(array2).map(&:sum)
  end
end
