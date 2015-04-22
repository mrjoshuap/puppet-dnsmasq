# == Resource Type: dnsmasq::host
#
# This type creates either an globally or locally exported dnsmasq host resource
# that will be collected by `::dnsmasq`, based on the boolean value `::dnsmasq::exported`
#
# At the end of the day, it is responsible for managing `::dnsmasq::hosts_file` and
# `::dnsmasq::ethers_file` entries.
#
# NOTE: If `mac` is not specified, no `ethers_file` entry will be made.
#
# === Parameters
#
# [*ip*]
#   The IP Address of the host.  This string parameter is required.
#
# [*aliases*]
#   This is a space separated list of hostname aliases for this host.
#
# [*ensure*]
#   Should the host be `absent` or `present`, defaults to `present`
#
# [*hostname*]
#   This should be the FQDN hostname of the host, defaults to `name`.
#
# [*mac*]
#   This is the hexadecimal string value MAC address of the host.
#
# === Variables
#
# This class makes use of the following variables:
#
# [*dnsmasq::exported*]
#   This boolean enables global exported resources (default) or local exported
#   resources, which are mainly useful for masterless environments.
#
# [*dnsmasq::ethers_file*]
#   The location of the ethers file, defaults to /etc/ethers
#
# [*dnsmasq::hosts_file*]
#   The location of the hosts files, defaults to /etc/hosts
#
# === Examples
#
#     include ::dnsmasq
#
# To create a hosts and ethers entry:
#
#     dnsmasq::host { 'client1.local':
#       aliases  => 'server1',
#       ip       => '1.2.3.4',
#       mac      => '11.22.33.44.55.66',
#     }
#
# To only create a hosts entry:
#
#     dnsmasq::host { 'server1.local':
#       aliases  => 'server1',
#       ip       => '1.2.3.4',
#     }
#
# === Authors
#
# Steffen Zieger
# Josh Preston
#
# === Copyright
#
# Copyright 2011 Steffen Zieger
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
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
    # "

    $ethers_ensure = $mac ? {
      ''      => 'absent',
      default => $ensure,
    }
    if str2bool($::dnsmasq::exported) {
      debug('DNSMASQ: using exported file_line resources')
      @@file_line { "dnsmasq::ethers ${h_real} ${mac_r}":
        ensure   => $ethers_ensure,
        path     => $dnsmasq::ethers_file,
        line     => "${mac_r} ${ip}",
        multiple => false,
        match    => "^${mac_r}",
        notify   => Class['dnsmasq::reload'],
        tag      => 'dnsmasq-host',
      }
    } else {
      debug('DNSMASQ: bypassing exported file_line resources')
      @file_line { "dnsmasq::ethers ${h_real} ${mac_r}":
        ensure   => $ethers_ensure,
        path     => $dnsmasq::ethers_file,
        line     => "${mac_r} ${ip}",
        match    => "^${mac_r}",
        multiple => false,
        notify   => Class['dnsmasq::reload'],
        tag      => 'dnsmasq-host',
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
  $ip_r = regsubst($ip, '\.', '\\\.', 'G')
  if str2bool($::dnsmasq::exported) {
    debug('DNSMASQ: using exported file_line resources')
    @@file_line { "dnsmasq::hosts ${h_real} ${ip}":
      ensure => $hosts_ensure,
      path   => $::dnsmasq::hosts_file,
      match  => "^${ip_r}",
      line   => "${ip} ${h_real}${al_add}",
      notify => Class['dnsmasq::reload'],
      tag    => 'dnsmasq-host',
    }
  } else {
    debug('DNSMASQ: bypassing exported file_line resources')
    @file_line { "dnsmasq::hosts ${h_real} ${ip}":
      ensure => $hosts_ensure,
      path   => $::dnsmasq::hosts_file,
      match  => "^${ip_r}",
      line   => "${ip} ${h_real}${al_add}",
      notify => Class['dnsmasq::reload'],
      tag    => 'dnsmasq-host',
    }
  }

}
