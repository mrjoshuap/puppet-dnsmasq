# == Resource Type: dnsmasq::collect
#
# This type enables collected resources
#
class dnsmasq::collect {
  debug('DNSMASQ: using exported file_line resources')
  File_line <<| tag == 'dnsmasq-host' |>>
}

