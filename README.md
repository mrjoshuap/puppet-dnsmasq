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

Manage dnsmasq via Puppet

## Module Description

What the module does and why it is useful.

## Setup

The basics of getting started with dnsmasq.

### What dnsmasq Affects

This module manages dnsmasq which affects the following:

    /etc/ethers         #- DHCP Client Mapping
    /etc/hosts          #- DNS Lookups (FQDN and aliases)
    /etc/dnsmasq.conf   #- main dnsmasq config file (include dir)
    /etc/dnsmasq.d/*    #- dnsmasq managed include config directory

### Setup Requirements

1.  Install
    `puppet module install mrjoshuap/dnsmasq`
2.  Include the module
    `include ::dnsmasq`
3.  Configure with Hiera
4.  Paydirt

### Beginning with dnsmasq

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
