class KeyGen

 	def self.generate_key
    key = ''
    5.times { key += rand(9).to_s }
    key
  end

  def self.generate_date
    key = ''
    6.times { key += rand(9).to_s }
    key
  end
end
