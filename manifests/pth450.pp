# @summary
#   Install Dracal USB pth450 support.
#
# @param tarfile
#   Name of tarfile to install.
#
class ccs_hcu::pth450 (
  String $tarfile = 'dracalview-client-bin-3.2.2.tar.xz',
) {
  $ptitle = regsubst($title, '::.*', '', 'G')

  $bindir = '/usr/local/bin'

  archive { "/var/tmp/${tarfile}":
    ensure          => present,
    source          => "${ccs_hcu::pkgurl}/${tarfile}",
    username        => $ccs_hcu::pkgurl_user.unwrap,
    password        => $ccs_hcu::pkgurl_pass.unwrap,
    extract         => true,
    extract_path    => $bindir,
    extract_command => 'tar --no-same-owner -axf %s',
    cleanup         => false,
    user            => 'root',
    group           => 'root',
    ## It creates some other files too.
    creates         => "${bindir}/dracal-usb-get",
  }

  ## Add udev rule to set permissions.
  $udev = '70-dracal.rules'

  file { "/etc/udev/rules.d/${udev}":
    ensure => 'file',
    source => "puppet:///modules/${ptitle}/${udev}",
    notify => Exec['udevadm pth450'],
  }

  exec { 'udevadm pth450':
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
