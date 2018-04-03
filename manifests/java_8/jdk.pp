# Installs Java 8 JDK package.
#
# @param package Package name
#
# @example basic usage
#   include vjava::java_8::jdk
#
# Copyright 2018 valsr
class vjava::java_8::jdk(String $package){
  v_ensure_packages($package)
}
