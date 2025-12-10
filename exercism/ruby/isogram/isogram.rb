class Isogram
  def self.isogram?(input)
    downcased_chars = input.downcase.scan(/\w/)
    downcased_chars.uniq.eql? downcased_chars
  end
end
