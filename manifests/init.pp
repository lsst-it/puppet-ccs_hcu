# @summary
#   Install hcu-specific stuff.
#
# @param quadbox
#   True if this is a quadbox host.
# @param advec
#   True (or 'present') if need specified module;
#   false (or 'absent') removes it; 'nothing' does nothing.
# @param canbus
#   True (or 'present') if need specified module;
#   false (or 'absent') removes it; 'nothing' does nothing.
# @param vldrive
#   True (or 'present') if need specified module;
#   false (or 'absent') removes it; 'nothing' does nothing.
# @param imanager
#   True (or 'present') if need specified module;
#   false (or 'absent') removes it; 'nothing' does nothing.
# @param filter_changer
#   True (or 'present') to install; false (or 'absent') to remove.
# @param aiousb
#   True to install aiousb.
# @param shutter
#   True to install shutter utilities.
# @param ft4232h
#   true or false to enable ft4232h.
# @param pth450
#   True to install Dracal USB-PTH450 sensor support.
# @param pkgurl
#   String specifying URL to fetch sources from.
# @param pkgurl_user
#   String specifying username to access pkgurl.
# @param pkgurl_pass
#   String specifying password to access pkgurl.
#
class ccs_hcu (
  Boolean $quadbox = false,
  Variant[Boolean,String] $advec = false,
  Variant[Boolean,String] $canbus = false,
  Variant[Boolean,String] $vldrive = false,
  Variant[Boolean,String] $imanager = false,
  Variant[Boolean,String] $filter_changer = false,
  Boolean $aiousb = false,
  Boolean $ft4232h = false,
  Boolean $pth450 = false,
  Boolean $shutter = false,
  String $pkgurl = 'https://example.org',
  Variant[Sensitive[String[1]],String[1]] $pkgurl_user = Sensitive('someuser'),
  Sensitive[String[1]] $pkgurl_pass = Sensitive('somepass'),
) {
  $opts0 = {
    'advec'          => $advec,
    'canbus'         => $canbus,
    'vldrive'        => $vldrive,
    'imanager'       => $imanager,
    'filter_changer' => $filter_changer,
  }

  $opts1 = $opts0.map |$key, $value| {
    [$key, $value ? {
        true    => 'present',
        false   => 'absent',
        default => $value,
  }] }

  $opts = Hash(flatten($opts1))

  ## Frequently needed on HCUs.
  ## The -devel packages in the ccs_hcu role (easier due to crb repo).
  ensure_packages(['libusb'])

  class { 'ccs_hcu::power':
    ensure  => present,
    quadbox => $quadbox,
  }

  class { 'ccs_hcu::advec':
    ensure => $opts['advec'],
  }

  class { 'ccs_hcu::canbus':
    ensure => $opts['canbus'],
  }

  class { 'ccs_hcu::vldrive':
    ensure => $opts['vldrive'],
  }

  class { 'ccs_hcu::imanager':
    ensure => $opts['imanager'],
  }

  class { 'ccs_hcu::filter_changer':
    ensure => $opts['filter_changer'],
  }

  if $ft4232h {
    include ccs_hcu::ft4232h
  }

  if $shutter {
    include ccs_hcu::shutter
  }

  if $aiousb {
    include ccs_hcu::aiousb
  }

  if $pth450 {
    include ccs_hcu::pth450
  }
}
