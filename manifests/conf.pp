# == Class: dnsmasq::conf
#
# This generates a configuration suitable to be dropped into $dnsmasq::config_dir
#
# === Parameters
#
# Document parameters here.
#
# [*ensure*]
#   config file ensure value set to 'present' or 'absent', default is 'present'
#
# [*prio*]
#   give a 2 digit priority / load order, default is 10
#
# [*source*]
#   use this string as source to the config file, default is undef
#
# [*content*]
#   use this string as the content to the config file, default is undef
#
# [*template*]
#   use this string as the template to render as config file, default is undef
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
#  dnsmasq::conf { 'filterwin2k':
#    content => "filterwin2k",
#  }
#
#  dnsmasq::conf { 'config_name':
#    prio   => 99,
#    source => "puppet:///modules/${module_name}/config_name",
#  }
#
#  dnsmasq::conf { 'my_config':
#    template => "${module_name}/my_config",
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
  $content  = undef,
  $ensure   = 'present',
  $prio     = '10',
  $source   = undef,
  $template = undef,
) {

  if $ensure == 'present' and !$source and !$content and !$template {
    fail("No source, content or template specified for dnsmasq::conf[${name}]")
  }
  elsif !$source and $content and $template {
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
