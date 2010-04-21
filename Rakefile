require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:development)
rescue Bundler::BundlerError => e
  STDERR.puts e.message
  STDERR.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'
require 'jeweler'
require './lib/dm-is-read_only/is/version.rb'

Jeweler::Tasks.new do |gem|
  gem.name = 'dm-predefined'
  gem.version = DataMapper::Is::ReadOnly::VERSION
  gem.license = 'MIT'
  gem.summary = %Q{A DataMapper plugin for making Models absolutely read-only.}
  gem.description = %Q{A DataMapper plugin for making Models absolutely read-only.}
  gem.email = 'postmodern.mod3@gmail.com'
  gem.homepage = 'http://github.com/postmodern/dm-is-read_only'
  gem.authors = ['Postmodern']
  gem.add_dependency 'dm-core', '>= 0.10.2'
  gem.add_development_dependency 'rspec', '~> 1.3.0'
  gem.add_development_dependency 'yard', '~> 0.5.3'
  gem.has_rdoc = 'yard'
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs += ['lib', 'spec']
  spec.spec_files = FileList['spec/**/*_spec.rb']
  spec.spec_opts = ['--options', '.specopts']
end

task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new
