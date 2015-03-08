# == Class: dnsmasq::config
#
# This class generates the main configuration file used by dnsmasq.  The config
# file needs to include the $dnsmasq::config_dir.
#
# NOTE: To create dnsmasq configurations in Puppet code, refer to dnsmasq::conf
# for more information.
#
# NOTE: To create dnsmasq configurations using Hiera, refer to dnsmasq::configs
# for more information.
#
# === Parameters
#
# This class inherits ::dnsmasq which means it has the same parameters, that said,
# this class should not be called directly.
#
# === Variables
#
# This module uses the following variables to work properly.
#
# [*dnsmasq::config_template*]
#   Specifies an alternative config template.
#
# [*dnsmasq::config_file*]
#   Specifies the configuration file to manage.
#
# [*dnsmasq::config_dir*]
#   Specifies the directory where configuration files created with dnsmasq::conf
#   will be managed.  By default we purge and recurse these.
#
# === Examples
#
# This class is not meant to be called directly, it should be loaded properly
# with a `include ::dnsmasq`.
#
#     include ::dnsmasq
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
class dnsmasq::config inherits dnsmasq {

  if $::dnsmasq::config_template {
    $config_template_real = $::dnsmasq::config_template
  } else {
    $config_template_real = "${module_name}/dnsmasq.conf.erb"
  }

  file { $::dnsmasq::config_file:
    ensure  => file,
    owner   => '0',
    group   => '0',
    mode    => '0644',
    content => template($config_template_real),
  } ->
  file { $::dnsmasq::config_dir:
    ensure  => directory,
    owner   => '0',
    group   => '0',
    recurse => true,
    purge   => true,
    force   => true,
  }

}
