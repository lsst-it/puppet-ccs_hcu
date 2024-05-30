# @summary
#   Install shutter utilities.
#
class ccs_hcu::shutter () {
  $ptitle = regsubst($title, '::.*', '', 'G')

  $bindir = '/usr/local/bin'

  $scripts = [
    'decodePtpConfig.py',
    'decodePtpDiag.py',
    'ptpCoeSetup.sh',
    'readPtpConfig.sh',
    'readPtpDiag.sh',
  ]

  ## ptpCoeSetup.sh should really be 0644, since it gets sourced.
  $scripts.each | String $script | {
    file { "${bindir}/${script}":
      ensure => 'file',
      source => "puppet:///modules/${ptitle}/${script}",
      mode   => '0755',
    }
  }

  $binaries = ['adstool']

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

  ## vim-common is for the xxd utility used by the ptp scripts.
  ensure_packages(['python3', 'vim-common'])
}
