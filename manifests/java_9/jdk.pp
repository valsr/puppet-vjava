# Installs Java 9 JDK package.
#
# @param package Package name
#
# @example basic usage
#   include vjava::java_9::jdk
#
# Copyright 2018 valsr
class vjava::java_9::jdk(String $package){
  v_ensure_packages($package)
}
