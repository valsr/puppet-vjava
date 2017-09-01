# Main class for Java installation will install the default Java Runtime Environment.
#
# @param default Whether to install default java version or not
#
# @example basic usage
#   include vbase::software::java::init
# Copyright 2017 valsr
class vjava(Boolean $default = true){

  if $default{
    include vjava::params
    case $vjava::params::default_java_version {
      8: { include vjava::java_8::jre }
      9: { include vjava::java_9::jre }
      default: {fail("Don't know how to install Java ${vjava::params::default_java_version}")}
    }

    # setup alternatives

      if $::osfamily == 'Debian' {
      # Needed for update-java-alternatives
      package { 'java-common':
        ensure => latest,
        before => Class['vjava::config']
      }
    }
  }

  include vjava::config
}
