# @summary
#   Configure DKMS for module
#
# @param ensure
#   String saying whether to install ('present') or remove ('absent') module.
#
# @param module
#   Name of module
#
# @param version
#   Version String
#
# @param archive
#   Name of Archive resource to order upon.
#
define ccs_hcu::dkms (
  Enum['present', 'absent'] $ensure,
  String $module,
  String $version,
  String $archive,
) {
  ## We still need most of these even if ensure = absent.
  ensure_packages(['dkms', 'gcc', 'make', 'kernel-devel', 'kernel-headers'])

  case $ensure {
    'present': {
      exec { "dkms install ${module}":
        path      => ['/usr/sbin', '/usr/bin'],
        # lint:ignore:strict_indent
        command   => @("CMD"/L),
          sh -c 'dkms add -m ${module} -v ${version} && \
          dkms build -m ${module} -v ${version} && \
          dkms install -m ${module} -v ${version}'
          | CMD
        # lint:endignore
        unless    => "sh -c 'dkms status | grep -q ^${module}'",
        subscribe => Archive[$archive],
      }
    }
    'absent': {
      exec { "dkms remove ${module}":
        path    => ['/usr/sbin', '/usr/bin'],
        command => "dkms remove -m ${module} -v ${version} --all",
        onlyif  => "sh -c 'dkms status | grep -q ^${module}'",
      }
    }
    default: {}
  }
}
