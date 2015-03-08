# == Class: dnsmasq::host
#
# Full description of class dnsmasq::host here.
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
#  dnsmasq::host { 'server2.local':
#    aliases  => 'server2',
#    ip       => '1.2.3.4',
#    mac      => '11.22.33.44.55.66',
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
define dnsmasq::host (
  $ip,
  $aliases  = undef,
  $ensure   = 'present',
  $hostname = undef,
  $mac      = false,
) {
  $h_real = $hostname ? {
    undef   => $name,
    default => $hostname,
  }

  if $mac != false {
    $mac_r = inline_template('<%= mac.upcase! -%>')
    debug("DNSMASQ: ${h_real} ${ip} ${mac_r}")

    $ethers_ensure = $mac ? {
      ''      => 'absent',
      default => $ensure,
    }
    if $::dnsmasq::exported {
      @@common::line { "dnsmasq::ethers ${h_real} ${mac_r}":
        ensure => $ethers_ensure,
        file   => $dnsmasq::ethers_file,
        line   => "${mac_r} ${ip}",
        notify => Class['dnsmasq::reload'],
        tag    => 'dnsmasq-host',
      }
    }
    else {
      @common::line { "dnsmasq::ethers ${h_real} ${mac_r}":
        ensure => $ethers_ensure,
        file   => $dnsmasq::ethers_file,
        line   => "${mac_r} ${ip}",
        notify => Class['dnsmasq::reload'],
        tag    => 'dnsmasq-host',
      }
    }
  }
  $al_add = $aliases ? {
    undef   => '',
    default => " ${aliases}",
  }

  $hosts_ensure = $ip ? {
    ''      => 'absent',
    default => $ensure,
  }
  if $::dnsmasq::exported {
    @@common::line { "dnsmasq::hosts ${h_real} ${ip}":
      ensure => $hosts_ensure,
      file   => $::dnsmasq::hosts_file,
      line   => "${ip} ${h_real}${al_add}",
      notify => Class['dnsmasq::reload'],
      tag    => 'dnsmasq-host',
    }
  } else {
    @common::line { "dnsmasq::hosts ${h_real} ${ip}":
      ensure => $hosts_ensure,
      file   => $::dnsmasq::hosts_file,
      line   => "${ip} ${h_real}${al_add}",
      notify => Class['dnsmasq::reload'],
      tag    => 'dnsmasq-host',
    }
  }
}
