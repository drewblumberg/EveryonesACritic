require 'optparse'

class ParseArguments
  def self.parse
    options = {}

    OptionParser.new do |opts|
      opts.banner = "Usage: eac [command] [category] [options]"

      opts.on("--genre [GENRE]", "The genre") do |genre|
        options[:genre] = genre
      end

      opts.on("--year [YEAR]", "The year") do |year|
        options[:year] = year
      end

      opts.on("--length [LENGTH]", "The length") do |length|
        options[:length] = length
      end

      opts.on("--budget [BUDGET]", "The budget") do |budget|
        options[:budget] = budget
      end

      opts.on("--mpaa [MPAA]", "The mpaa") do |mpaa|
        options[:mpaa] = mpaa
      end

      opts.on("--environment [ENV]", "The database environment") do |env|
        options[:environment] = env
      end
    end.parse!
    options
  end

  def self.validate(options, category)
    errors = ""
    if options[:name].nil? or options[:name].empty?
      errors << "You must provide the name of the movie you are creating.\n"
    end

    missing_things = []
    missing_things << "genre" unless options[:genre]
    missing_things << "year" unless options[:year]
    missing_things << "length" unless options[:length]
    missing_things << "budget" unless options[:budget]
    missing_things << "mpaa" unless options[:mpaa]
    unless missing_things.empty?
      errors << "You must provide the #{missing_things.join(" and ")} of the #{category} you are adding.\n"
    end
    errors
  end

end