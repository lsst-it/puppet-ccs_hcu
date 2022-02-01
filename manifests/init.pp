# @summary
#   Install hcu-specific stuff.
#
# @param quadbox
#   True if this is a quadbox host.
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
# @param ft4232h
#   true or false to enable ft4232h.
#
class ccs_hcu (
  Boolean $quadbox = false,
  Variant[Boolean,String] $canbus = false,
  Variant[Boolean,String] $vldrive = false,
  Variant[Boolean,String] $imanager = false,
  Variant[Boolean,String] $filter_changer = false,
  Boolean $ft4232h = false,
) {
  $opts0 = {
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

  class { 'ccs_hcu::power':
    ensure  => present,
    quadbox => $quadbox,
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
}
