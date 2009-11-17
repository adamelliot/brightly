require 'rubygems'
require 'optparse'

module Brightly
  module Server
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

          opts.on_tail('-h', '--help', "Show this message") { puts opts ; exit }
        end

        Brightly::Server::Base.run! options
      end
    end
  end
end