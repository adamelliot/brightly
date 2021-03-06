require 'rubygems'
require 'optparse'
require 'fileutils'

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
            config = rack_file

            puts "#{config}:"
            puts File.read(config)
            exit
          end
          
          opts.on('-p path', '--passenger path', 'Generate an apache passenger config and directory structure.') do |val|
            config = rack_file
            
            FileUtils.mkdir_p(File.join(val))
            FileUtils.mkdir_p(File.join(val, 'tmp'))
            FileUtils.mkdir_p(File.join(val, 'public'))

            FileUtils.cp(config, File.join(val))

            puts "You apache conf should look something like:"
            puts <<-CONF
<VirtualHost *:80>
    ServerName brightly.local
    DocumentRoot #{File.expand_path(File.join(val, 'public'))}
</VirtualHost>
CONF
            exit
          end

          opts.on_tail('-h', '--help', "Show this message") { puts opts ; exit }
        end.parse!

        Brightly::Provider::Base.run! options
      end
      
      private
        def rack_file
          a = File.dirname(__FILE__).split(File::SEPARATOR)
          a.slice!(-5, 5)
          a += ['lib', 'brightly', 'provider']
          config = File.join(a.join(File::SEPARATOR), 'config.ru')
        end
    end
  end
end