# Installs Java 8 JDK package.
#
# @example basic usage
#   include vjava::java_8::jdk
#
# Copyright 2017 valsr
class vjava::java_8::jdk{
  include vjava::params
  include vjava::config

  package{$vjava::params::java[8][jdk][package]:
    ensure => latest
  }->Class['vjava::config']
}
