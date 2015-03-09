# puppet-dnsmasq

[![Build Status](https://travis-ci.org/mrjoshuap/puppet-dnsmasq.svg?branch=master)](https://travis-ci.org/mrjoshuap/puppet-dnsmasq)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with dnsmasq](#setup)
    * [What dnsmasq affects](#what-dnsmasq-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with dnsmasq](#beginning-with-dnsmasq)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Manage dnsmasq via Puppet

## How to use

```
    dnsmasq::conf { 'local-dns':
        ensure => present,
        source => 'puppet:///files/dnsmasq/local-dns',
    }
```

or

```
    dnsmasq::conf { 'another-config':
        ensure  => present,
        content => 'dhcp-range=192.168.0.50,192.168.0.150,12h',
    }
```
