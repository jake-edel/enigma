class KeyGen

 	def self.generate_key
    key = ''
    5.times { key += rand(9).to_s }
    key
  end

  def self.generate_date
    require 'pry-byebug'; binding.pry
  end
end
