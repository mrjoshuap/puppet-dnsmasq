# Class: dnsmasq::configs
#
# This class enables support for a full hiera based sudoers configuration.
# Hiera functionality is auto enabled during the initial dnsmasq module load;
#   this class is not intended to be loaded directly.
#
# See the primary dnsmasq module documentation for usage and examples.
#
class dnsmasq::configs {

  # NOTE: hiera_hash does not work as expected in a parameterized class
  #   definition; so we call it here.
  #
  # http://docs.puppetlabs.com/hiera/1/puppet.html#limitations
  # https://tickets.puppetlabs.com/browse/HI-118
  #
  $configs = hiera_hash('dnsmasq::configs', undef)

  if $configs {
    create_resources('::dnsmasq::conf', $configs)
  }

}
