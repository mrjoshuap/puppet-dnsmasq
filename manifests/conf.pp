# == Class: dnsmasq::conf
#
# Full description of class dnsmasq::conf here.
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
#  dnsmasq::conf { 'config_name':
#    content => "puppet:///modules/${module_name}/config_name",
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
define dnsmasq::conf (
  $ensure   = 'present',
  $prio     = 10,
  $source   = undef,
  $content  = undef,
  $template = undef,
) {

  if !$source and $content and $template {
    # content wins!
    $content_real = $content
  }
  elsif !$source and $template {
    $content_real = template($template)
  }
  else {
    $content_real = undef
  }

  file { "${::dnsmasq::config_dir}${prio}-${name}":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    content => $content_real,
    source  => $source,
    notify  => Class['dnsmasq::service'],
  }

}
