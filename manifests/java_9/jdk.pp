# Installs Java 9 JDK package.
#
# @example basic usage
#   include vjava::java_9::jdk
#
# Copyright 2017 valsr
class vjava::java_9::jdk{
  include vjava::params
  include vjava::config

  package{$vjava::params::java[9][jdk][package]:
    ensure => latest
  }->Class['vjava::config']
}
