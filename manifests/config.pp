# == Class: dnsmasq::config
#
# Full description of class dnsmasq::config here.
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
#  class { 'dnsmasq::config':
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
class dnsmasq::config inherits dnsmasq {

  if $::dnsmasq::config_template {
    $config_template_real = $::dnsmasq::config_template
  } else {
    $config_template_real = "${module_name}/dnsmasq.conf"
  }

  File {
    owner => '0',
    group => '0',
  } ->
  file { $::dnsmasq::config_file:
    mode    => '0644',
    content => template($config_template_real),
  } ->
  file { $::dnsmasq::config_dir:
    ensure  => 'directory',
    recurse => true,
    purge   => true,
    force   => true,
  }

}
