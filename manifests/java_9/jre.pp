# Installs Java 9 Java runtime environment.
#
# @param package Package name
#
# @example basic usage
#   include vjava::java_9::jre
#
# Copyright 2018 valsr
class vjava::java_9::jre(String $package){
  v_ensure_packages($package)
}
