require 'rubygems'
require 'puppet-lint/tasks/puppet-lint'
require 'rspec-puppet'
#require 'puppetlabs_spec_helper/rake_tasks'

require 'rspec/core/rake_task'

PuppetLint.configuration.fail_on_warnings
PuppetLint.configuration.send('disable_autoloader_layout')
PuppetLint.configuration.send('disable_class_inherits_from_params_class')
PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.ignore_paths = ["spec/**/*.pp", "pkg/**/*.pp"]

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/*/*_spec.rb'
end

desc "Validate manifests, templates, and ruby files"
task :validate do
  Dir['manifests/**/*.pp'].each do |manifest|
    sh "puppet parser validate --noop #{manifest}"
  end
  Dir['spec/**/*.rb','lib/**/*.rb'].each do |ruby_file|
    sh "ruby -c #{ruby_file}" unless ruby_file =~ /spec\/fixtures/
  end
  Dir['templates/**/*.erb'].each do |template|
    sh "erb -P -x -T '-' #{template} | ruby -c"
  end
end

# TODO: add the :spec to run RSpec tests
desc "Default to validate manifests, templates, and ruby files"
task :default => [:validate, :lint]
