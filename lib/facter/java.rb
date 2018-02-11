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
  confine :kernel => "Linux"

  setcode do
    java = {}

    # default java
    j_default = nil
    begin
      output = Facter::Util::Resolution.exec("java -version 2>&1").split("\n")[0]
      /openjdk version "(\d\.(?<release>\d)\.\d_(\d+)|(?<release>\d)-internal|(?<release>\d)\.(\d)\.(\d))"/.match(output) do |m|
        j_default = m[:release]
      end
    rescue Facter::Core::Execution::ExecutionFailure
      warning("Failed executing 'java -version'. Java may not be installed")
      j_default = nil
    end
    java[:default] = j_default

    javas = []
    begin
      javas = Facter::Util::Resolution.exec("update-alternatives --list java").split
    rescue
      warning("Failed executing 'update-alternatives --list java'")
    end

    javas.each do | version |
      begin
        output = Facter::Util::Resolution.exec("#{version} -version 2>&1").split("\n")[0]
        /openjdk version "(\d\.(?<release>\d)\.\d_(\d+)|(?<release>\d)-internal|(?<release>\d)\.(\d)\.(\d))"/.match(output) do |m|
          j_release = m[:release]
          j_home = version
          j_type = nil

          /^(.*java-[^-]+-openjdk-([^\\\/]+)).*$/.match(version) do |m|
            j_home = m[1]
            j_type = m[2]
          end

          java[j_release] = {:home => j_home, :type => j_type, :default => j_release == j_default}
        end
      rescue Facter::Core::Execution::ExecutionFailure
        warning("Failed executing '#{version} -version'")
      end
    end

    java
  end
end
