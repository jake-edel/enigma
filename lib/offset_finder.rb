module OffsetFinder
  def self.find_shifts(key, date)
    sum_arrays(find_consecutive_values(key), offsets_from_date(date))
  end

  def self.find_consecutive_values(digit_string)
    
    digit_string.chars.each_cons(2).map { |cons| cons.join('').to_i }
  end

  def self.offsets_from_date(digit_string)
    last_four_of_squared_value(digit_string).map(&:to_i)
  end

  def self.last_four_of_squared_value(digit_string)
    (digit_string.to_i**2).to_s[-4..-1].split('')
  end

  def self.sum_arrays(array1, array2)
    array1.zip(array2).map(&:sum)
  end
end
