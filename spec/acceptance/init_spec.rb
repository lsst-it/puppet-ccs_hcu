# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'ccs_hcu class' do
  context 'without any parameters' do
    let(:manifest) do
      <<-PP
      include epel
      include ccs_hcu

      Class[epel] -> Class[ccs_hcu]
      PP
    end

    it_behaves_like 'an idempotent resource'
  end
end
