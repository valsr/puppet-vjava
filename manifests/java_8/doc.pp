# Installs Java 8 documentation.
#
# @example basic usage
#   include vjava::java_8::doc
#
# Copyright 2017 valsr
class vjava::java_8::doc{
  include vjava::params
  include vjava::config

  package{$vjava::params::java[8][doc][package]:
    ensure => latest
  }->Class['vjava::config']
}
