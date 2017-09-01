# Installs Java 8 debugging symbols.
#
# @example basic usage
#   include vjava::java_8::dbg
#
# Copyright 2017 valsr
class vjava::java_8::dbg{
  include vjava::params
  include vjava::config

  package{$vjava::params::java[8][dbg][package]:
    ensure => latest
  }->Class['vjava::config']
}
