require 'optparse'

class CommandLineArguments

  def initialize(arguments)
    @options = {}
    optionsParser = OptionParser.new do |opts|
      opts.banner = "USAGE: phretrieve.rb -f filename[,filename,...] -d destination-directory -n nef-directory"
      extractFilenames(opts)
      extractDestination(opts)
      extractNefDir(opts)
    end
    begin optionsParser.parse!(ARGV)
    rescue OptionParser::InvalidOption => e
      printUsageError(e, optionsParser)
    end
    begin checkForMissingArguments
    rescue OptionParser::MissingArgument => e
      printUsageError(e, optionsParser)
    end
  end

  def checkForMissingArguments
    raise OptionParser::MissingArgument if @options[:source].nil?
    raise OptionParser::MissingArgument if @options[:destination].nil?
    raise OptionParser::MissingArgument if @options[:picasa].nil?
  end

  def extractPicasa(opts)
    opts.on("-p", "--picasa-dir PICASA", "Picasa directory.") do |p|
      @options[:picasa] = p
    end
  end

  def extractDestination(opts)
    opts.on("-d", "--destination-dir DESTINATION", "Destination directory.") do |d|
      @options[:destination] = d
    end
  end

  def extractFilenames(opts)
    opts.on("-f", "--filenames FILENAMES", "List of comma seperated filenames ot retrieve.") do |f|
      @options[:filenames] = f
    end
  end

  def printUsageError(e, optionsParser)
    abort("#{e}\n#{optionsParser}")
  end

  def sourceDirectory()
    sourceArg = File.expand_path(@options[:source], File.dirname(__FILE__))
    if self.directoryExists?(sourceArg)
      p sourceArg
      return sourceArg
    end
    abort("Directory '#{sourceArg}' does not exist!")
  end

  def destinationDirectory()
    destinationArg = File.expand_path(@options[:destination], File.dirname(__FILE__))
    if self.directoryExists?(destinationArg)
      return destinationArg
    end
    abort("Directory '#{destinationArg}' does not exist!")
  end

  def picasaDirectory()
    picasaArg = File.expand_path(@options[:picasa], File.dirname(__FILE__))
    if self.directoryExists?(picasaArg)
      return picasaArg
    end
    abort("Directory '#{picasaArg}' does not exist!")
  end

  def directoryExists?(path)
    return File.directory?(path)
  end

end