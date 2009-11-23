# Generic config for Brightly, should be usable from any rack instance
begin
  require 'brightly'
rescue
  require 'rubygems'
  require 'brightly'
end
run Brightly::Provider::Base
