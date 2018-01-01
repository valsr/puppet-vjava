# Java Software Parameters. You wouldn't use this class for configuration, instead use the globals class.
#
# Copyright 2017 valrs
class vjava::params inherits vjava::globals {
  case $::osfamily {
    'Debian': {
      $oracle_architecture = $::architecture ? {
        'amd64' => 'x64',
        default => $::architecture
      }
      case $::lsbdistcodename {
        'stretch','xenial', 'yakkety', 'zesty', 'sarah', 'serena', 'sonya', 'sylvia': {
          $default_java_version = $vjava::globals::default_version
          $java = {
            8 => {
              jre => {
                package => 'openjdk-8-jre',
                alternative => "java-1.8.0-openjdk-${::architecture}",
                alternative_path=> "/usr/lib/jvm/java-1.8.0-openjdk-${::architecture}/bin/java",
                java_home=> "/usr/lib/jvm/java-1.8.0-openjdk-${::architecture}/",
              },
              jdk => {
                package => 'openjdk-8-jdk'
              },
              dbg => {
                package => 'openjdk-8-dbg',
              },
              doc => {
                package => 'openjdk-8-doc',
              }
            },
            9 =>{
              jre => {
                package => 'openjdk-9-jre',
                alternative => "java-1.9.0-openjdk-${::architecture}",
                alternative_path=> "/usr/lib/jvm/java-1.9.0-openjdk-${::architecture}/bin/java",
                java_home => "/usr/lib/jvm/java-1.9.0-openjdk-${::architecture}/",
              },
              jdk => {
                package => 'openjdk-9-jdk',
              },
              dbg => {
                package => 'openjdk-9-dbg',
              },
              doc => {
                package => 'openjdk-9-doc',
              }
            }
          }
        }
        default: {fail("Unsupported distro ${::lsbdistcodename}") }
      }
    }
    default: { fail("Unsupported platform ${::osfamily}") }
  }

  if !has_key($java, $default_java_version) {
    fail("Unknown java version ${default_java_version}")
  }
  $java_default = $java[$default_java_version]
}
