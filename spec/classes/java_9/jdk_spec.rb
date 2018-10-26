# frozen_string_literal: true

require 'spec_helper'
describe 'vjava::java_9::jdk' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile.with_all_deps }

      it { should contain_package('openjdk-9-jdk') }
    end
  end
end
