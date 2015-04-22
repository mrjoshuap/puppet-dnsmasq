== Class: dnsmasq::hosts

This class enables support for a full hiera based dnsmasq::host configuration.
Hiera functionality is auto enabled during the initial dnsmasq module load;
  this class is not intended to be loaded directly.

See the primary dnsmasq module documentation for usage and examples.

=== Examples

This class is not meant to be called directly, it should be loaded properly
with a `include ::dnsmasq`.

    include ::dnsmasq

The hiera needed to make the magic happen looks like:

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

