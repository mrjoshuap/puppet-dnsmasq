== Class: dnsmasq::reload

Send a HUP signal to any dnsmasq processes in order to reload changes from
`/etc/hosts` and `/etc/ethers` and any file given by `--dhcp-hostsfile`,
`--dhcp-optsfile` or `--addn-hosts`.

This is necessary because the SysV script on Ubuntu doesn't provide a
reload command. It will not reload configuration changes. It will also
send a HUP to *all* dnsmasq processes, of which there may be more than
one, however that should be harmless.

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

