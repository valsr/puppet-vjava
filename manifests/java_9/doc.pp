# Installs Java 9 documentation.
#
# @example basic usage
#   include vjava::java_9::doc
#
# Copyright 2017 valsr
class vjava::java_9::doc{
  include vjava::params
  include vjava::config

  package{$vjava::params::java[9][doc][package]:
    ensure => latest
  }->Class['vjava::config']
}
