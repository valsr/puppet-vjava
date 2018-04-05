# Main class for Java installation will install the default Java Runtime Environment.
#
# @param default Whether to install default java version or not
#
# @example basic usage
#   include vjava

# Copyright 2017 valsr
class vjava(Optional[Integer] $default_version = undef){
  if $default_version {
    include "vjava::java_${default_version}::jre"
    include vjava::config

    Class["vjava::java_${default_version}::jre"]->Class['vjava::config']
  }

  if $::osfamily == 'Debian' {
    # Needed for update-java-alternatives
    v_ensure_packages('java-common')
  }
}
