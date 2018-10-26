# Main class for Java installation will install the default Java Runtime Environment.
#
# @param default Whether to install default java version or not
#
# @example basic usage
#   include vjava

# Copyright 2017 valsr
class vjava(
  Optional[Integer] $default_version,
  Optional[String] $alternative,
  Optional[String] $alternative_path,
  Optional[String] $java_home,
  ){
  if $default_version {
    contain "vjava::java_${default_version}::jre"

    case $facts['os']['family'] {
      'Debian': {
        if $alternative != undef and $alternative_path != undef {
          exec { 'update-java-alternatives':
            path    => '/usr/bin:/usr/sbin:/bin:/sbin',
            command => "update-java-alternatives --set ${alternative}",
            unless  => "test /etc/alternatives/java -ef '${alternative_path}'",
            require => Package['java-common']
          }
        }
        elsif $java_home != undef {
          file_line { 'java-home-environment':
            path  => '/etc/environment',
            line  => "JAVA_HOME=${$java_home}",
            match => 'JAVA_HOME=',
          }
        }
      }
      default: {
        # Do nothing.
      }
    }
  }

  case $facts['os']['family'] {
    'Debian': {
        v_ensure_packages('java-common')
      }
      default: {}
    }

}
