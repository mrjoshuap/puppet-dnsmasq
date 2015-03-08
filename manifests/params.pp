# == Class: dnsmasq::params
#
# Full description of class dnsmasq::params here.
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
#  class { 'dnsmasq::params':
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
class dnsmasq::params {

  $exported = true
  $service_name = 'dnsmasq'
  $config_file = '/etc/dnsmasq.conf'
  $resolv_file = '/etc/resolv.conf-dnsmasq'
  $config_dir = '/etc/dnsmasq.d/'
  $config_template = "${module_name}/dnsmasq.conf.erb"
  $hosts_file = '/etc/hosts'
  $ethers_file = '/etc/ethers'

  case $::osfamily {
    debian: {
      $package_name = 'dnsmasq'
    }
    redhat: {
      $package_name = 'dnsmasq'
    }
    gentoo: {
      $package_name = 'net-dns/dnsmasq'
    }
    default: {
      case $::operatingsystem {
        default: {
          fail("Unsupported platform: ${::osfamily}/${::operatingsystem}")
        }
      }
    }
  }
}
