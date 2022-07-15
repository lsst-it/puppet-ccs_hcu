# frozen_string_literal: true

require 'spec_helper'

describe 'ccs_hcu' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      describe 'without params' do
        it { is_expected.to compile.with_all_deps }
      end
    end
  end
end
