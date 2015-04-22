# == Resource Type: dnsmasq::dhcp_host
#
# This type is responsible for creating the necessary `dnsmasq::host` and
# `dnsmasq::conf` objects to enable dhcp-host dnsmasq configuration files.
#
# === Parameters
#
# [*mac*]
#   This is the hexadecimal string value MAC address of the host.  This string
#   parameter is required.
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
# [*lease*]
#   This is how long a lease should last, defaults to `infinite`.
#
# [*prio*]
#   This is the priority of the resulting configuration file, defaults to `99`.
#
# === Variables
#
# This class does not make use of the any variables.
#
# === Examples
#
#     include ::dnsmasq
#
#     dnsmasq::dhcp_host { 'client1.local':
#       mac     => '00:11:22:33:44:55',
#       ip      => '2.3.4.5',
#       aliases => 'client1',
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
# Making life easier
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
    ''        => $name,
    default   => $hostname,
  }
  $add_real = $ip ? {
    ''        => $h_real,
    default   => "${h_real},${ip},${lease}",
  }

  dnsmasq::host { $name:
    ensure   => $ensure,
    aliases  => $aliases,
    hostname => $hostname,
    ip       => $ip,
    mac      => $mac,
  }

  dnsmasq::conf { "dhcp-host_${h_real}_${mac}":
    ensure  => $ensure,
    content => "dhcp-host=${mac},id:*,${add_real}\n",
    prio    => $prio,
    notify  => Class['dnsmasq::service'],
  }

}
