# frozen_string_literal: true

# Java installation facts - which javas are installed and what is the system default java version. All facts are stored
# in a hash with the version of each java (7, 8, 9) as key. Note that only installed versions are listed.
# A default key is used to store the system default java version. The structure is as follow:
#
# {
#   'version' => {
#     home => home directory,
#     type => architecture (amd64, i386, etc),
#     default => true/false
#   }
#  'version' => ...
#   default => version
#  }
#
# @example default java version
#   $facts['java']['default'] == '8'
#
# @example specific java version is installed
#   if member($facts['java'], '8') and $facts['java']['8']['installed'] { ..
#
# Copyright 2018 valsr
Facter.add(:java) do
  confine kernel: 'Linux'

  setcode do
    java = {}

    # default java
    j_default = nil
    cmd = Puppet::Util::Execution.execute('java -version 2>&1', failonfail: false)
    output = cmd.exitstatus.zero? ? cmd.split("\n")[0] : ''
    %r{openjdk version "(\d\.(?<release>\d)\.\d_(\d+)|(?<release>\d)-internal|(?<release>\d)\.(\d)\.(\d))"}
      .match(output) do |m|
      j_default = m[:release]
    end
    java[:default] = j_default

    javas = []
    begin
      javas = Puppet::Util::Execution.execute('update-alternatives --list java').split
    rescue StandardError
      warn("Failed executing 'update-alternatives --list java'")
    end

    javas.each do |version|
      begin
        output = Puppet::Util::Execution.execute("#{version} -version 2>&1").split("\n")[0]
        %r{openjdk version "(\d\.(?<release>\d)\.\d_(\d+)|(?<release>\d)-internal|(?<release>\d)\.(\d)\.(\d))"}
          .match(output) do |release_match|
          j_release = release_match[:release]
          j_home = version
          j_type = nil

          %r{^(.*java-[^-]+-openjdk-([^\\\/]+)).*$}.match(version) do |version_match|
            j_home = version_match[1]
            j_type = version_match[2]
          end

          java[j_release] = { home: j_home, type: j_type, default: j_release == j_default }
        end
      rescue Puppet::ExecutionFailure
        warn("Failed executing '#{version} -version'")
      end
    end

    java
  end
end
