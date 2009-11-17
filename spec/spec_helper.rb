require 'rubygems'
require 'brightly'
require 'spec'
require 'spec/autorun'
require 'rack/test'

Spec::Runner.configure do |config|
  config.include Rack::Test::Methods

  # Add an app method for RSpec
  def app
    Rack::Lint.new(Brightly::Provider::Base.new)
  end
end
