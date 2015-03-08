# == Class: dnsmasq::dhcp_host
#
# Full description of class dnsmasq::dhcp_host here.
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
#  dnsmasq::dhcp_host { 'server1.local':
#    mac => '00:11:22:33:44:55',
#    ip  => '2.3.4.5',
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
# # Making life easier
define dnsmasq::dhcp_host (
  $mac,
  $aliases  = '',
  $ensure   = 'present',
  $hostname = '',
  $ip       = '',
  $lease    = 'infinite',
  $prio     = '99',
) {
  $h_real = $hostname ? {
    ''      => $name,
    default => $hostname,
  }
  $add_real = $ip ? {
    ''      => $h_real,
    default => "${h_real},${ip},${lease}",
  }

  dnsmasq::conf { "dhcp-host_${h_real}_${mac}":
    ensure  => $ensure,
    content => "dhcp-host=${mac},id:*,${add_real}\n",
    prio    => $prio,
    notify  => Exec['/usr/bin/pkill -HUP dnsmasq'],
  }
}
