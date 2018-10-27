# Main class for Java installation will install the default Java Runtime Environment.
#
# @param default_version Whether to install default java version or not
# @param alternative name to use when calling update-java-alternative to update default Java version
# @param alternative_path path to alternative JRE/JDK location
# @param java_home JAVA_HOME value to set if either alternative or alternative_path is undef
#
# @example basic usage
#   include vjava

# Copyright 2017 valsr
class vjava(
  Optional[Integer] $default_version = undef,
  Optional[String] $alternative = undef,
  Optional[String] $alternative_path = undef,
  Optional[String] $java_home = undef,
  ){
  if $default_version {
    contain "vjava::java_${default_version}::jre"

    case $facts['os']['family'] {
      'Debian': {
        if $alternative and $alternative_path {
          exec { 'update-java-alternatives':
            path    => '/usr/bin:/usr/sbin:/bin:/sbin',
            command => "update-java-alternatives --set ${alternative}",
            unless  => "test /etc/alternatives/java -ef '${alternative_path}'",
            require => Package['java-common']
          }
        }
      }
      default: {
        # Do nothing.
      }
    }
  }

  case $facts['kernel']{
    'Linux': {
      if $java_home {
        file_line { 'java-home-environment':
          path  => '/etc/environment',
          line  => "JAVA_HOME=${$java_home}",
          match => 'JAVA_HOME=',
        }
      }
    }
    default: {
      # do nothing
    }
  }

  case $facts['os']['family'] {
    'Debian': {
        v_ensure_packages('java-common')
      }
      default: {}
    }

}
