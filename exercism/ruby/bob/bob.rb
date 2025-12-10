class Bob
  def self.hey(input)
    case input
    in /\A[^a-z]*[A-Z]+[^a-z]*\?\z/ then "Calm down, I know what I'm doing!"
    in /\A[^a-z]*[A-Z]+[^a-z]*\z/ then "Whoa, chill out!"
    in /\A\s*\z/ then "Fine. Be that way!"
    in /\?\s*\z/x then "Sure."
    else "Whatever."
    end
  end
end