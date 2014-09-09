require 'optparse'

class CommandLineArguments

  def initialize(arguments)
    @options = {}
    optionsParser = OptionParser.new do |opts|
      opts.banner = "USAGE: phretrieve.rb -f filename[,filename,...] -d destination-directory -n nef-dir"
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
    raise OptionParser::MissingArgument if @options[:filenames].nil?
    raise OptionParser::MissingArgument if @options[:destination].nil?
    raise OptionParser::MissingArgument if @options[:nef].nil?
  end

  def extractFilenames(opts)
    opts.on("-f", "--filenames FILENAMES", "List of comma seperated filenames ot retrieve.") do |f|
      @options[:filenames] = f
    end
  end

  def extractDestination(opts)
    opts.on("-d", "--destination-dir DESTINATION", "Destination directory to store the retrieved NEFs.") do |d|
      @options[:destination] = d
    end
  end

  def extractNefDir(opts)
    opts.on("-n", "--nef-dir NEF", "Top level NEF directory.") do |n|
      @options[:nef] = p
    end
  end

  def printUsageError(e, optionsParser)
    abort("#{e}\n#{optionsParser}")
  end

  def filenames()
    filenamesArg = Filenames.parseCommaSeperatedList(@options[:source])
  end

  def destinationDirectory()
    destinationArg = File.expand_path(@options[:destination], File.dirname(__FILE__))
    if self.directoryExists?(destinationArg)
      return destinationArg
    end
    abort("Directory '#{destinationArg}' does not exist!")
  end

  def nefDirectory()
    nefArg = File.expand_path(@options[:nef], File.dirname(__FILE__))
    if self.directoryExists?(nefArg)
      return nefArg
    end
    abort("Directory '#{nefArg}' does not exist!")
  end

  def directoryExists?(path)
    return File.directory?(path)
  end

end