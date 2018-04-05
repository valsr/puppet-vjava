# Configures java installation. Currently this sets up default java version
#
# Copyright 2017 valsr
class vjava::config inherits vjava{
  if $vjava::default_version {
    $java_alternative = lookup("vjava::${vjava::default_version}::alternative", String, 'first', '')
    $java_alternative_path = lookup("vjava::${vjava::default_version}::alternative_path", String, 'first', '')
    $java_home = lookup("vjava::${vjava::default_version}::java_home", String, 'first', '')

    case $::osfamily {
      'Debian': {
        if $java_alternative != undef and $java_alternative_path != undef {
          v_ensure_packages('java-common')
          exec { 'update-java-alternatives':
            path    => '/usr/bin:/usr/sbin:/bin:/sbin',
            command => "update-java-alternatives --set ${java_alternative}",
            unless  => "test /etc/alternatives/java -ef '${java_alternative_path}'",
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
}
