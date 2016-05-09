# Variables:
#
# SIMP_GEM_SERVERS | a space/comma delimited list of rubygem servers
# PUPPET_VERSION   | specifies the version of the puppet gem to load
puppetversion = ENV.key?('PUPPET_VERSION') ? "#{ENV['PUPPET_VERSION']}" : '~>3'
gem_sources   = ENV.key?('GEM_SERVERS') ? ENV['GEM_SERVERS'].split(/[, ]+/) : ['https://rubygems.org']

gem_sources.each { |gem_source| source gem_source }

gem 'rake'
gem 'facter', '>= 1.7.0'
gem 'puppet', puppetversion
gem 'puppet-lint', '>= 0.3.2'
gem 'rspec-puppet'
gem 'puppetlabs_spec_helper', '>= 0.1.0'
