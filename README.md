# puppet-dnsmasq

[![Build Status](https://travis-ci.org/mrjoshuap/puppet-dnsmasq.svg?branch=master)](https://travis-ci.org/mrjoshuap/puppet-dnsmasq)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What dnsmasq Affects](#what-dnsmasq-affects)
    * [Setup Requirements](#setup-requirements)
    * [Beginning with dnsmasq](#beginning-with-dnsmasq)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Manage dnsmasq via Puppet.  This module was derived on the excellent work of Steffen Zieger.

From http://www.thekelleys.org.uk/dnsmasq/doc.html

    Dnsmasq provides network infrastructure for small networks: DNS, DHCP, router
    advertisement and network boot. It is designed to be lightweight and have a
    small footprint, suitable for resource constrained routers and firewalls. It
    has also been widely used for tethering on smartphones and portable hotspots,
    and to support virtual networking in virtualisation frameworks. Supported
    platforms include Linux (with glibc and uclibc), Android, *BSD, and Mac OS X.
    Dnsmasq is included in most Linux distributions and the ports systems of
    FreeBSD, OpenBSD and NetBSD. Dnsmasq provides full IPv6 support.

## Module Description

This module manages dnsmasq server installations.  It provides the following types:

* [`dnsmasq::conf`](docs/conf.md)
* [`dnsmasq::dhcp_host`](docs/dhcp_host.md)
* [`dnsmasq::host`](docs/host.d)

Configurations can be created and managed preferably with Hiera or alternatively
through Puppet Code.

It supports exporting virtual resources with the `dnsmasq::exported` class
parameter, so `dnsmasq::dhcp_host` types can be managed in Puppet Code and
the server will automatically import those resources.  If you are running with
no Puppet Master (masterless), set `dnsmasq::exported` to `false`.

## Setup

The basics of getting started with dnsmasq.

### What dnsmasq Affects

This module manages dnsmasq which affects the following:

```
    /etc/ethers         #- DHCP Client Mapping
    /etc/hosts          #- DNS Lookups (FQDN and aliases)
    /etc/dnsmasq.conf   #- main dnsmasq config file (include dir)
    /etc/dnsmasq.d/*    #- dnsmasq managed include config directory
```

The config directory is a managed directory by default.  Any non-managed configurations
located in it will be removed.  If you wish to disable this behavior, set `dnsmasq::purge` to `false`.

### Setup Requirements

1.  Install

    `puppet module install mrjoshuap/dnsmasq`
2.  Include the module in your Puppet Code

    `include ::dnsmasq`
3.  Configure with Hiera
4.  Configure with Puppet Code
5.  Paydirt

### Beginning with dnsmasq

First, the default configuration template only includes configuration files
in the `::dnsmasq::config_dir`.  This means that to do anything interesting,
you'll want to build some basic configuration.  This typically means setting
bind interfaces, and other options specific to your site.

For example, use a template that looks like:
* `some_module/templates/dnsmasq.d/my-site.erb`
```
    domain-needed
    bogus-priv
    resolv-file=<%= scope.lookupvar('::dnsmasq::resolv_file') %>
    local=/<%= scope.lookupvar('::domain') -%>/
    listen-address=127.0.0.1
    listen-address=<%= scope.lookupvar('::ipaddress') %>
    no-dhcp-interface=lo
    bind-interfaces
    expand-hosts
    domain=<%= scope.lookupvar('::domain') -%>,10.0.1.0/24
    selfmx
```

Then configure it with Hiera:
```
    dnsmasq::configs:
      my-site:
        ensure: present
        prio: 01
        template: some_module/dnsmasq.d/my-site.erb
```

#### Configurations: Hiera

The preferred way to configure dnsmasq is with the use of Hiera.

Source a static configuration file
```
    dnsmasq::configs:
      local-dns:
        source: puppet:///files/dnsmasq/local-dns
```

or, Specify the exact content
```
    dnsmasq::configs:
      another-config:
        content: dhcp-range=192.168.0.50,192.168.0.150,12h
```

or, Specify a template to be rendered
```
    dnsmasq::configs:
      another-config:
        ensure: present
        template: some_module/dnsmasq-template.erb
```

#### Configurations: Puppet Code

Although not preferred, you can also create configurations with Puppet code.

Source a static configuration file
```
    ::dnsmasq::conf { 'local-dns':
      ensure => present,
      source => 'puppet:///files/dnsmasq/local-dns',
    }
```

or, Specify the exact content
```
    ::dnsmasq::conf { 'another-config':
      ensure  => present,
      content => 'dhcp-range=192.168.0.50,192.168.0.150,12h',
    }
```

or, Render your own template
```
    ::dnsmasq::conf { 'another-config':
      ensure  => present,
      content => template('some_module/dnsmasq-template.erb'),
    }
```

or, Specify a template to be rendered
```
    ::dnsmasq::conf' { 'another-config':
      ensure   = 'present',
      template = 'some_module/dnsmasq-template.erb',
    }
```

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
