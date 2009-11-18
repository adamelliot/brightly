<code language="ruby">
require 'highline'
  
namespace :generate do
  desc "Do something with CLI"
  task "Enter username & password" do
    username = HighLine.new.ask("Please enter the 'username': ") do |q|
      q.validate = /[a-zA-z][a-zA-Z0-9]{2,8}$/
    end
    password = HighLine.new.ask("Please enter the 'admin' password: ") do |q|
      q.echo = false
    end
  end
end
</code>