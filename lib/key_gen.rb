class KeyGen

  def self.generate_key
    key = ''
    5.times { key += rand(9).to_s }
    key
  end

  def self.generate_date
    today = Time.now
    year = today.year.to_s[-2..-1]
    month = today.month.to_s.rjust(2, '0')
    day = today.day.to_s.rjust(2, '0')
    year + month + day
  end
end
