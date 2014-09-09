require_relative 'command_line_arguments'

class Phretrieve

  def initialize(arguments)
    @arguments = arguments
  end

  def retrieveNefs()

  end

end

commandLineArguments = CommandLineArguments.new(ARGV)
phretrieve = Phretrieve.new(commandLineArguments)
phretrieve.retrieveNefs()

puts "*Phretrieval Complete*"