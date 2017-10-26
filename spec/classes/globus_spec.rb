require 'spec_helper'

describe 'globus' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { should compile.with_all_deps }

      it { is_expected.to create_class('globus') }
      it { is_expected.to contain_class('globus::params') }

      it { is_expected.to contain_class('epel').that_comes_before('Class[globus::repo::el]') }
      it { is_expected.to contain_class('globus::repo::el').that_comes_before('Class[globus::install]') }
      it { is_expected.to contain_class('globus::install').that_comes_before('Class[globus::config]') }
      it { is_expected.to contain_class('globus::config').that_comes_before('Class[globus::service]') }
      it { is_expected.to contain_class('globus::service') }

      it_behaves_like 'globus::repo::el', facts
      it_behaves_like 'globus::install', facts
      it_behaves_like 'globus::config', facts
      it_behaves_like 'globus::service', facts
    end
  end
end
