class LogLineParser
  attr_reader :message, :log_level, :reformat

  def initialize(line)
    @line = line
    @message = extract_message
    @log_level = extract_log_level
    @reformat = reformat_message
  end

  private

  def extract_message
    scan[:message].strip
  end

  def extract_log_level
    scan[:level].downcase
  end

  def reformat_message
    message + " (#{log_level})"
  end

  def scan
    @line.match(
      /\[(?<level>\w+)\]: (?<message>.+)/
    )
  end
end
