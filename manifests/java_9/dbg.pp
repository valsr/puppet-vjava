# Installs Java 9 debugging symbols.
#
# @example basic usage
#   include vjava::java_9::dbg
#
# Copyright 2017 valsr
class vjava::java_9::dbg{
  include vjava::params
  include vjava::config

  package{$vjava::params::java[9][dbg][package]:
    ensure => latest
  }->Class['vjava::config']
}
