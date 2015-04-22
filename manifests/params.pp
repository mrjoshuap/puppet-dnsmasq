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
class dnsmasq::params {

  $exported = true
  $service_name = 'dnsmasq'
  $config_file = '/etc/dnsmasq.conf'
  $resolv_file = '/etc/resolv.conf-dnsmasq'
  $config_dir = '/etc/dnsmasq.d/'
  $config_template = "${module_name}/dnsmasq.conf.erb"
  $hosts_file = '/etc/hosts'
  $ethers_file = '/etc/ethers'
  $purge = true

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
