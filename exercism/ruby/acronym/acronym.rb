# frozen_string_literal: true

module Acronym
  def self.abbreviate(phrase)
    raise StandardError, "must be a string. we got: #{phrase}" unless phrase.is_a?(String)

    phrase
      .split(/[\s-]+/)
      .map(&:chr)
      .join
      .upcase
  end
end

class Abbreviator
  include Acronym

  attr_reader :phrase, :abbreviation

  def initialize(phrase)
    @phrase = phrase
    @abbreviation = abbreviate
  end

  private

  def abbreviate
    Acronym.abbreviate(phrase)
  end
end
