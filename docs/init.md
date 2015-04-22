== Class: dnsmasq

This class manages dnsmasq.  By default, it wants to be run with a puppet master,
and utilizes globally exported resources to populate hosts and but can work in
a masterless setup.

It is also recommended to go full on Hiera for ease of use.  Sample hiera yaml
files are distributed with this module.

=== Parameters

Document parameters here.  All default values are specified in `dnsmasq::params`.

[*config_dir*]
  This is the location where config files will be included from.  Defaults to
  `/etc/dnsmasq.d`.

[*config_file*]
  This is the main configuration file for dnsmasq.  Defaults to `/etc/dnsmasq.conf`.

[*config_template*]
  This is to specify the template for the main configuration file.  Defaults to
  `${module_name}/dnsmasq.conf.erb`.

[*ethers_file*]
  This is the file used to manage `mac` and `ip`, which is commonly used for
  mapping dhcp clients.  Defaults to `/etc/ethers`.

[*exported*]
  Boolean value that specifies whether to globally export required resources or not.
  Pro-tip: specify `false` if running masterless.  Defaults to `true`.

[*hosts_file*]
  This is the file used to manage `ip` and `hostname` and `aliases`, which is
  used as for local hostname lookups.  Defaults to `/etc/hosts`.

[*package_name*]
  The name of the dnsmasq package.  Defaults based on `::osfamily`.

[*resolv_file*]
  Specify an alternative `resolv.conf` file that dnsmasq will use.  Defaults to
  `/etc/resolv.conf-dnsmasq`

[*service_name*]
  This is the name of the dnsmasq service.  Defaults based on `::osfamily`.

=== Variables

Here you should define a list of variables that this module would require.

[*::puppetversion*]
  This is used to detect whether Hiera auto includes should be enabled.

=== Examples

Masterless Puppet Code:

    class { 'dnsmasq':
      exported => false,
    }

Masterless Hiera Puppet Code:

    include ::dnsmasq

Masterless Hiera Data:

    dnsmasq::exported: false
    dnsmasq::dhcp_hosts:
      somehost.example.domain.local:
        mac: 00:11:22:33:44:55
        ip: 192.168.100.1
        aliases: somehost somehost.local
      client1.example.domain.local:
        mac: 11:22:33:44:55:66
        ip: 10.0.1.253
        aliases: client1 client1.local
    dnsmasq::hosts:
      server.example.domain.local:
        ip: 192.168.100.1
        aliases: server server.local
      client2.example.domain.local:
        ip: 10.0.1.254
        aliases: client2 client2.local

=== Authors

Steffen Zieger
Josh Preston

=== Copyright

Copyright 2011 Steffen Zieger

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

