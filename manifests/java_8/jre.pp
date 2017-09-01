# Installs Java 8 Java runtime environment.
#
# @example basic usage
#   include vjava::java_8::jre
#
# Copyright 2017 valsr
class vjava::java_8::jre{
  include vjava::params
  include vjava::config

  package{$vjava::params::java[8][jre][package]:
    ensure => latest
  }->Class['vjava::config']
}
