class TwoFer
  LANGUAGE = {
    English: 'One for %<name>s, one for me.',
    Español: 'Uno para %<name>s, uno para mi.',
    Esparanto: 'Unu por %<name>s, unu por mi.'
  }

  # Convenience method that will assume "you" is the person we are sharing with,
  # otherwise will use the name given:
  #     doctest: Default behavior for our convenience method
  #     >> TwoFer.two_fer
  #     => "One for you, one for me."
  #     doctest: Given a name, 'José' the convenience method will use it.
  #     >> TwoFer.two_fer('José')
  #     => "One for José, one for me."
  def self.two_fer(name = 'you')
    new(name).to_s
  end

  private

  attr_reader :name, :language

  def initialize(name, language: :English)
    @name = name
    @language = language
  end

  public

  def to_s
    LANGUAGE[language] % { name: name }
  end
end

TEST_HASH = {
  TwoFer.two_fer('José') => 'One for José, one for me.',
  TwoFer.new('Joseph').to_s => 'One for Joseph, one for me.',
  TwoFer.new('José', language: :Español).to_s => 'Uno para José, uno para mi.'
}.each do |key, value|
  unless key == value
    raise <<~ERROR
      uhhohh:
      incorrect translation!
      got:          #{key},
      but expected: #{value}
    ERROR
  end
end
