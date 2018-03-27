# Provides overridable globals class.
#
# @param default_version Default java version, integer, optional.
# @example basic usage
#   class {'vbase::software::java::globals':
#     default_java_version = 8,
#     ...
#   }
# Copyright 2017 valsr
class vjava::globals(Optional[Integer] $default_version = 8){
}
