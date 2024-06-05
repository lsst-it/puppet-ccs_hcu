# @summary
#   Install aiousb.
#
class ccs_hcu::aiousb () {
  $ptitle = regsubst($title, '::.*', '', 'G')

  $hex_path = '/usr/share/usb'

  ensure_resources('file', {
      $hex_path => {
        ensure => directory,
        owner  => 'root',
        group  => 'root',
        mode   => '0755',
        backup => false,
      },
  })

  $hexes = ['USB-DIO-96.hex']

  $hexes.each | String $hex | {
    archive { "/var/tmp/${hex}":
      ensure   => present,
      source   => "${ccs_hcu::pkgurl}/${hex}",
      username => $ccs_hcu::pkgurl_user.unwrap,
      password => $ccs_hcu::pkgurl_pass.unwrap,
    }
    file { "${hex_path}/${hex}":
      ensure => file,
      source => "/var/tmp/${hex}",
      mode   => '0644',
    }
  }

  ensure_packages(['fxload'])

  $bindir = '/usr/local/bin'

  ## EL7 version of fxload is too old.
  if fact('os.family') == 'RedHat' and fact('os.release.major') == '7' {
    $binaries = ['fxload']

    $binaries.each | String $binary | {
      archive { "/var/tmp/${binary}":
        ensure   => present,
        source   => "${ccs_hcu::pkgurl}/${binary}",
        username => $ccs_hcu::pkgurl_user.unwrap,
        password => $ccs_hcu::pkgurl_pass.unwrap,
      }
      file { "${bindir}/${binary}":
        ensure => file,
        source => "/var/tmp/${binary}",
        mode   => '0755',
      }
    }
  } else {
    ## Alternative would be make the udev rule conditional on OS version.
    file { "${bindir}/fxload":
      ensure => link,
      target => '/sbin/fxload',
    }
  }

  ## Add udev rule to load device firmware and set permissions.
  $udev = '10-acces_usb.rules'

  file { "/etc/udev/rules.d/${udev}":
    ensure => 'file',
    source => "puppet:///modules/${ptitle}/${udev}",
    notify => Exec['udevadm aiousb'],
  }

  exec { 'udevadm aiousb':
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
