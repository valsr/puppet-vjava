# Installs Java 8 documentation.
#
# @param package Package name
#
# @example basic usage
#   include vjava::java_8::doc
#
# Copyright 2018 valsr
class vjava::java_8::doc(String $package){
  v_ensure_packages($package)
}
