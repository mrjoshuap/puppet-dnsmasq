# == Resource Type: dnsmasq::conf
#
# This type generates a configuration file suitable to be dropped into
# $dnsmasq::config_dir.
#
# NOTE: If you're looking to create dnsmasq configurations using Hiera, refer to
# dnsmasq::configs for more information.
#
# === Parameters
#
# At a minimum, you must specify one of `content`, `source`, or `template`.  If
# multiples are specified, the winner is chosen in the following order:
#
#   1. `template`
#   2. `content`
#   3. `source`
#
# [*ensure*]
#   config file ensure value set to 'present' or 'absent', default is 'present'
#
# [*prio*]
#   give a 2 digit priority / load order, default is '10'
#
# [*source*]
#   use this string as source to the config file, default is undef
#
# [*content*]
#   use this string as the content to the config file, default is undef
#
# [*template*]
#   use this string as the template to render as config file, default is undef
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*dnsmasq::config_dir*]
#   the config_dir is used as the location to create the configuration file.
#
# === Examples
#
#   include ::dnsmasq
#
#   dnsmasq::conf { 'filterwin2k':
#     content => "filterwin2k",
#   }
#
#   dnsmasq::conf { 'config_name':
#     prio   => '75',
#     source => "puppet:///modules/${module_name}/config_name",
#   }
#
#   dnsmasq::conf { 'my_config':
#     prio     => '15'
#     template => "${module_name}/my_config",
#   }
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
define dnsmasq::conf (
  $content  = undef,
  $ensure   = 'present',
  $prio     = '10',
  $source   = undef,
  $template = undef,
) {

  if $template {
    # template wins!
    $content_real = template($template)
    $source_real = undef
  }
  elsif $content {
    # content wins.
    $content_real = $content
    $source_real = undef
  }
  elsif $source {
    # source wins...
    $content_real = undef
    $source_real = $source
  } elsif $ensure == 'present' {
    fail("No source, content or template specified for dnsmasq::conf[${name}]")
  }

  file { "${::dnsmasq::config_dir}${prio}-${name}":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    content => $content_real,
    source  => $source_real,
    notify  => Class['dnsmasq::service'],
  }

}
