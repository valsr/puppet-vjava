# frozen_string_literal: true

require 'spec_helper'

describe 'vjava' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile.with_all_deps }

      it { should contain_class('vjava') }

      it 'should include default version from hiera' do
        should contain_class('vjava::java_8::jre')
      end

      # context 'when configuring alternatives' do
      #  hiera = Hiera.new(config: 'spec/fixtures/hiera/hiera.yaml').lookup('vjava::default_version')
      # end
    end

    context 'on Debian family' do
      let(:facts) { { 'os' => { 'family': 'Debian' } } }

      context 'when setting configurations' do

        it { should contain_package('java-common') }

        context 'when default version is specified' do
          it do
            should contain_exec('update-java-alternatives').with(
              'path' => '/usr/bin:/usr/sbin:/bin:/sbin',
              'command' => 'update-java-alternatives --set java-1.8.0-openjdk-amd64',
              'unless' => 'test /etc/alternatives/java -ef \'/usr/lib/jvm/java-1.8.0-openjdk-amd64/bin/java\'',
            )
          end

          context 'when alternative is undef' do
            let(:hiera_config) { 'spec/fixtures/hiera/java.noaltprovided.yaml' }
            let(:params) do
              { 'java_home': 'test' }
            end
            it do
              should contain_file_line('java-home-environment')
                .with(
                  'path' => '/etc/environment',
                  'line' => 'JAVA_HOME=test',
                  'match' => 'JAVA_HOME=',
                )
            end
          end
        end
      end
    end
  end
end
