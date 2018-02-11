# vjava

## Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with vjava](#setup)
    * [What vjava affects](#what-vjava-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with vjava](#beginning-with-vjava)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)
1. [Release Notes](#release-notes)

## Description

vjava module installs and configures Java environments. Is addition, it plays nice with other modules allowing
ad-hoc (runtime) environment installation, configuration.

## Setup

At most you will need to have vdata installed in order to use hiera data lookups.

### What vjava affects

* JRE/JDK installations
* JAVA home path/variable
* Default Java run-time association

### Setup requirements

N/A

### Beginning with vjava

Simplest case is to include the default java class. This will install the default java environment (JRE). The default
version is controlled by the **vjava::globals default_version** parameter (use hiera for lookups):
```.pp
include vjava
```

## Usage

If you need/want to install additional JRE/JDK/DOC/Debugging symbols, simply include the desired version:
```.pp
include vjava::9::jre
include vjava::9::jdk
include vjava::9::doc
include vjava::9::dbg
```

Configuring the default version of java is accomplished by setting the vjava::globals default_version parameter to
the java version. It is recommended to configure this via hiera lookup instead of hard coding it. By default a default
java 8 is the default version.

```.pp
class{'vjava::globals':
    default_version => 9
    }
```

### Facts

Module includes several facts regarding java installation. These are all under the java fact and show the default java
version as well as known installed java versions. The fact is a hash with each installed version being represented as a
hash. The 'default' key only holds the current default java version (from calling `java -version`).

**Example**:
```puppet
java{
  default => '8',
 '8' => {
   home => '/usr/lib/jvm/java-8-openjdk-amd64',
   type => 'amd64',
   default => true
 }
'9' => ...
}
```

## Reference

> Generate documents first by running **puppet strings generate**

See [doc/index.html](doc/index.html) for reference documentation.

## Limitations

Module build against Puppet 5.

Tested on:

- Ubuntu 16.04 LTS

## Development

See [CONTRIBUTING.md](CONTRIBUTING.md)

## Release Notes

See [CHANGELOG.md](CHANGELOG.md)
