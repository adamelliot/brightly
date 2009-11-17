require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "brightly"
    gem.summary = %Q{Simple standalone web app that adds syntax highlighting to Markdown}
    gem.description = %Q{Adds syntax highlighting and some other code stuff to Markdown}
    gem.email = "adam@warptube.com"
    gem.homepage = "http://github.com/adamelliot/brightly"
    gem.authors = ["Adam Elliot"]

#    gem.rubyforge_project = "brightly"
    gem.add_dependency "sinatra", ">= 0.9.4"
    gem.add_dependency "ultraviolet", ">= 0.10.2"
    gem.add_dependency "rdiscount", ">= 1.3.5"

    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_development_dependency "rack-test", ">= 0.5.0"

    gem.executables = ['brightly']
  end
  Jeweler::GemcutterTasks.new
  Jeweler::RubyforgeTasks.new do |rubyforge|
    rubyforge.doc_task = "yardoc"
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.spec_opts = %W{--options \"#{File.dirname(__FILE__)}/spec/spec.opts\"}
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.spec_opts = %W{--options \"#{File.dirname(__FILE__)}/spec/spec.opts\"}
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
  spec.rcov_opts = lambda do
     IO.readlines("#{File.dirname(__FILE__)}/spec/rcov.opts").map {|l| l.chomp.split " "}.flatten
   end
end

task :spec => :check_dependencies

begin
  require 'reek/rake_task'
  Reek::RakeTask.new do |t|
    t.fail_on_error = true
    t.verbose = false
    t.source_files = 'lib/**/*.rb'
  end
rescue LoadError
  task :reek do
    abort "Reek is not available. In order to run reek, you must: sudo gem install reek"
  end
end

task :default => :spec

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end
