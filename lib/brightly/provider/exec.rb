require 'rubygems'
require 'optparse'

module Brightly
  module Provider
    class Exec
      def initialize(argv)
        options = {}

        OptionParser.new do |opts|
          opts.banner { "Usage: brightly [options]" }
          # Sinatra params
          opts.on('-x')         {       options[:lock] = true }
          opts.on('-s server')  { |val| options[:server] = val }
          opts.on('-e env')     { |val| options[:environment] = val.to_sym }
          opts.on('-p port')    { |val| options[:port] = val.to_i }
          
          opts.on('-r', '--rack-file', 'Prints the path to the builtin rack file and the contents of the file.') do
            a = File.dirname(__FILE__).split(File::SEPARATOR)
            a.slice!(-5, 5)
            config = File.join(a.join('/'), 'config.ru')
            puts "#{config}:"
            puts File.read(config)
            exit
          end

          opts.on_tail('-h', '--help', "Show this message") { puts opts ; exit }
        end.parse!

        Brightly::Provider::Base.run! options
      end
    end
  end
end