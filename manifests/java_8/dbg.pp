# Installs Java 8 debugging symbols.
#
# @param package Package name
#
# @example basic usage
#   include vjava::java_8::dbg
#
# Copyright 2018 valsr
class vjava::java_8::dbg(String $package){
  v_ensure_packages($package)
}
