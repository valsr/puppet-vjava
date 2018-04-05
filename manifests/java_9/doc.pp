# Installs Java 9 documentation.
#
# @param package Package name
#
# @example basic usage
#   include vjava::java_9::doc
#
# Copyright 2018 valsr
class vjava::java_9::doc(String $package){
  v_ensure_packages($package)
}
