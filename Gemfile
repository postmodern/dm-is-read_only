#
# Environment Variables:
#
# DM_EDGE - Bundle against the DataMapper git repositories at
#           http://github.com/datamapper
# DM_BRANCH - The branch to use across all DataMapper git repositories.
# DM_ROOT - The path to the directory containing local copies of the DataMapper
#           libraries.
# ADAPTER(S) - The list of DataMapper adapters to test with.
#              (sqlite, postgres, mysql, oracle, sqlserver)
# PLUGIN(S) - The list of additional DataMapper plugins to test with.
#

source :rubygems

gemspec

if ENV['DM_EDGE']
  SOURCE    = :git
  DM_URI    = 'http://github.com/datamapper'
  DM_BRANCH = ENV.fetch('DM_BRANCH', 'master')
elsif ENV['DM_ROOT']
  SOURCE    = :path
  DM_ROOT   = File.expand_path(ENV['DM_ROOT'])
else
  SOURCE    = :gem
end

DM_VERSION  = '~> 1.2'
DO_VERSION  = '~> 0.10.6'
DO_ADAPTERS = %w[ sqlite postgres mysql oracle sqlserver ]

def dm_gem(name,repo=name)
  options = case SOURCE
            when :git
              {:git => "#{DM_URI}/#{repo}.git", :branch => DM_BRANCH}
            when :path
              {:path => "#{DM_ROOT}/#{repo}"}
            end

  gem name, DM_VERSION, options
end

def do_gem(name)
  dm_gem name, 'do'
end

group :datamapper do

  dm_gem 'dm-core'

  adapters = ENV['ADAPTER'] || ENV['ADAPTERS']
  adapters = adapters.to_s.tr(',', ' ').split.uniq - %w[ in_memory ]

  if (do_adapters = DO_ADAPTERS & adapters).any?
    do_gem 'data_objects'

    do_adapters.each do |adapter|
      adapter = 'sqlite3' if adapter == 'sqlite'
      do_gem "do_#{adapter}"
    end

    dm_gem 'dm-do-adapter'
  end

  adapters.each { |adapter| dm_gem "dm-#{adapter}-adapter" }

  plugins = ENV['PLUGINS'] || ENV['PLUGIN']
  plugins = plugins.to_s.tr(',', ' ').split.push('dm-migrations').uniq

  plugins.each { |plugin| dm_gem plugin }

end

group :development do
  gem 'rake',             '~> 0.8'
  gem 'rubygems-tasks',   '~> 0.1'
  gem 'rspec',            '~> 2.4'

  gem 'kramdown',   '~> 0.12'
end
