class PhoneNumber
  def self.clean(number)
    n = number.gsub(/[^0-9]/, '')

    return unless (10..11).cover? n.size

    return if %w[0 1].include? n[-10]
    return if %w[0 1].include? n[-7]

    if n.size == 11
      return if n[-10] == '0'

      return unless n[0] == '1'

      n = n[1..]
    end
    n
  end
end
