# == Class: dnsmasq::dhcp_hosts
#
# This class enables support for a full hiera based dnsmasq::dhcp_host configuration.
# Hiera functionality is auto enabled during the initial dnsmasq module load;
#   this class is not intended to be loaded directly.
#
# See the primary dnsmasq module documentation for usage and examples.
#
# === Examples
#
# This class is not meant to be called directly, it should be loaded properly
# with a `include ::dnsmasq`.
#
#     include ::dnsmasq
#
# The hiera needed to make the magic happen looks like:
#
#     dnsmasq::dhcp_hosts:
#       somehost.example.domain.local:
#         mac: 00:11:22:33:44:55
#         ip: 192.168.100.1
#         aliases: somehost somehost.local
#       client1.example.domain.local:
#         mac: 11:22:33:44:55:66
#         ip: 10.0.1.253
#         aliases: client1 client1.local
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
class dnsmasq::dhcp_hosts {

  # NOTE: hiera_hash does not work as expected in a parameterized class
  #   definition; so we call it here.
  #
  # http://docs.puppetlabs.com/hiera/1/puppet.html#limitations
  # https://tickets.puppetlabs.com/browse/HI-118
  #
  $configs = hiera_hash('dnsmasq::dhcp_hosts', undef)

  if $configs {
    create_resources('::dnsmasq::dhcp_host', $configs)
  }

}
