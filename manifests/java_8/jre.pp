# Installs Java 8 Java runtime environment.
#
# @param package Package name
#
# @example basic usage
#   include vjava::java_8::jre
#
# Copyright 2018 valsr
class vjava::java_8::jre(String $package){
  v_ensure_packages($package)
}
