module KeyGen
  def self.generate_key
    key = ''
    5.times { key += rand(9).to_s }
    key
  end

  def self.generate_date
    Time.now.strftime("%d%m%y")
  end

  def self.char_set
    (("a".."z").to_a << ' ')
  end
end
