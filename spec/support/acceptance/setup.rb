# frozen_string_literal: true

configure_beaker do |host|
  install_puppet_module_via_pmt_on(host, 'puppet/epel', '4')
end
