# Configures java installation. Currently this sets up default java version
#
# Copyright 2017 valsr
class vjava::config inherits vjava::params{
  $java_alternative=$vjava::params::java[$vjava::params::default_java_version][jre][alternative]
  $java_alternative_path=$vjava::params::java[$vjava::params::default_java_version][jre][alternative_path]
  $java_home=$vjava::params::java[$vjava::params::default_java_version][jre][java_home]

  if $vjava::default {
    case $::osfamily {
      'Debian': {
        if $java_alternative != undef and $java_alternative_path != undef {
          exec { 'update-java-alternatives':
            path    => '/usr/bin:/usr/sbin:/bin:/sbin',
            command => "update-java-alternatives --set ${java_alternative}",
            unless  => "test /etc/alternatives/java -ef '${java_alternative_path}'",
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
}
