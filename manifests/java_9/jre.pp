# Installs Java 9 Java runtime environment.
#
# @example basic usage
#   include vjava::java_9::jre
#
# Copyright 2017 valsr
class vjava::java_9::jre{
  include vjava::params
  include vjava::config

  package{$vjava::params::java[9][jre][package]:
    ensure => latest
  }->Class['vjava::config']
}
