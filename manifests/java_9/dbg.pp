# Installs Java 9 debugging symbols.
#
# @param package Package name
#
# @example basic usage
#   include vjava::java_9::dbg
#
# Copyright 2018 valsr
class vjava::java_9::dbg(String $package){
  v_ensure_packages($package)
}
