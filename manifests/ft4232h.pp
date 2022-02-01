# @summary
#   Add settings for FT4232H device.
#
class ccs_hcu::ft4232h () {
  $ptitle = regsubst($title, '::.*', '', 'G')

  ## Set /dev/bus/usb permissions for this device so libusb works.
  $udev = '99-ft4232h.rules'

  file { "/etc/udev/rules.d/${udev}":
    ensure => 'file',
    source => "puppet:///modules/${ptitle}/${udev}",
    notify => Exec['udevadm ft4232h'],
  }

  exec { 'udevadm ft4232h':
    path        => ['/usr/sbin', '/usr/bin'],
    # lint:ignore:strict_indent
    command     => @("CMD"/L),
    sh -c 'udevadm control --reload-rules && \
    udevadm trigger --type=devices --action=change'
    | CMD
    # lint:endignore
    refreshonly => true,
  }
}
