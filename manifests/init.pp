# == Class: dnsmasq
#
# Full description of class dnsmasq here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'dnsmasq':
#  }
#
# === Authors
#
# Josh Preston <joshua.preston@prestoncentral.com>
#
# === Copyright
#
# Copyright 2015 Josh Preston, unless otherwise noted.
#
class dnsmasq (
  $config_dir       = $::dnsmasq::params::config_dir,
  $config_file      = $::dnsmasq::params::config_file,
  $config_template  = $::dnsmasq::params::config_template,
  $package_name     = $::dnsmasq::params::package_name,
  $resolv_file      = $::dnsmasq::params::resolv_file,
  $service_name     = $::dnsmasq::params::service_name,
  ) inherits dnsmasq::params {

  validate_absolute_path($config_dir)
  validate_absolute_path($config_file)
  validate_string($config_template)
  validate_string($package_name)
  validate_string($service_name)
  validate_absolute_path($resolv_file)

  # Anchor this as per #8040 - this ensures that classes won't float off and
  # mess everything up.  You can read about this at:
  # http://docs.puppetlabs.com/puppet/2.7/reference/lang_containment.html#known-issues
  anchor { 'dnsmasq::begin': } ->
  class { '::dnsmasq::install': } ->
  class { '::dnsmasq::config': } ~>
  class { '::dnsmasq::service': } ->
  class { '::dnsmasq::reload': } ->
  anchor { 'dnsmasq::end': }

  # Load the Hiera based sudoer configuration (if enabled and present)
  #
  # NOTE: We must use 'include' here to avoid circular dependencies with
  #     sudo::conf
  #
  # NOTE: There is no way to detect the existence of hiera. This automatic
  #   functionality is therefore made exclusive to Puppet 3+ (hiera is embedded)
  #   in order to preserve backwards compatibility.
  #
  #   http://projects.puppetlabs.com/issues/12345
  #
  if (versioncmp($::puppetversion, '3') != -1) {
    include 'dnsmasq::configs'
  }

  Common::Line <<| tag == 'dnsmasq-host' |>>

}
