# @summary
#   Add (or remove) the advantech EC modules.
#   Replaces the older imanager.
#
# https://www.advantech.com/en-us/support/details/software-api?id=1-2JZ4BXI
#
# @param ensure
#   String saying whether to install ('present') or remove ('absent') module.
#
# @param module
#   Module name.
#
# @param version
#   Version string.
#
class ccs_hcu::advec (
  String $ensure = 'nothing',
  String $module = 'advec',
  String $version = '2.24',
) {
  if $ensure =~ /(present|absent)/ {
    ensure_packages(['xz', 'tar'])

    ## Patched version with dkms.conf, only gpio.
    $src = "${module}-${version}_dkms.tar.xz"
    $dest = "${module}-${version}"

    ## Ensure => absent does not delete the extracted file.
    archive { '/var/tmp/advec.tar.xz':
      ensure       => $ensure,
      extract      => true,
      extract_path => '/usr/src',
      source       => "${ccs_hcu::pkgurl}/${src}",
      username     => $ccs_hcu::pkgurl_user.unwrap,
      password     => $ccs_hcu::pkgurl_pass.unwrap,
      creates      => "/usr/src/${dest}",
      cleanup      => true,
    }

    ccs_hcu::dkms { 'advec':
      ensure  => $ensure,
      module  => $module,
      version => $version,
      archive => '/var/tmp/advec.tar.xz',
    }

    $ptitle = regsubst($title, '::.*', '', 'G')

    $conf = 'advec-gpio.conf'

    file { "/etc/modules-load.d/${conf}":
      ensure => $ensure,
      source => "puppet:///modules/${ptitle}/${conf}",
    }

    if $ensure == present {
      ensure_resources('group', {
          'gpio' => {
            'ensure'     => 'present',
            'forcelocal' => 'true',
            'system'     => 'true',
          }
      })

      exec { 'usermod ccs advec_gpio':
        path    => ['/usr/sbin', '/usr/bin'],
        command => 'usermod -a -G gpio ccs',
        unless  => 'sh -c "groups ccs | grep -q gpio"',
        require => Group['gpio'],
      }
    }

    ## Set /dev/advgpio: group gpio, mode 660 (default is root 600).
    $udev = '99-advec-gpio.rules'

    file { "/etc/udev/rules.d/${udev}":
      ensure => $ensure,
      source => "puppet:///modules/${ptitle}/${udev}",
      notify => Exec['udevadm advec-gpio'],
    }

    exec { 'udevadm advec-gpio':
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
}
