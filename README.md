# vjava

## Table of Contents

1.  [Description](#description)
2.  [Build Status](#build-status)
3.  [Setup - The basics of getting started with vjava](#setup)
    - [What vjava affects](#what-vjava-affects)
    - [Setup requirements](#setup-requirements)
    - [Beginning with vjava](#beginning-with-vjava)
4.  [Usage - Configuration options and additional functionality](#usage)
5.  [Limitations - OS compatibility, etc.](#limitations)
6.  [Development - Guide for contributing to the module](#development)
7.  [Release Notes](#release-notes)

## Description

vjava module installs and configures Java environments. Is addition, it plays nice with other modules allowing
ad-hoc (runtime) environment installation, configuration.

## Build Status

| Branch      | [Travis-CI](https://travis-ci.org/valsr/puppet-vjava/branches)                      |
| ----------- | ----------------------------------------------------------------------------------- |
| stable      | ![latest stable status](https://travis-ci.org/valsr/puppet-vjava.svg?branch=stable) |
| master      | ![master build status](https://travis-ci.org/valsr/puppet-vjava.svg?branch=master)  |
| development | N/A                                                                                 |

## Setup

At most you will need to have vdata installed in order to use hiera data lookups.

### What vjava affects

- JRE/JDK installations
- JAVA home path/variable
- Default Java run-time association

### Setup requirements

This module depends on **valsr-vcommon** to provide v_ensure_packages. See
[www.github.com/valsr/puppet-vcommon](www.github.com/valsr/puppet-vcommon) for explanation of what this functions does
(TL;DR it provides ability to specify package versions to be installed via hiera).

### Beginning with vjava

Each function/manifest file holds the description on how to use it. You can find more information in the
[Usage](#usage) section.

## Usage

`::vjava`

Simplest case to configure java is to include the vjava class. This will install the default java environment
(JRE) and other required packages. These defaults can be overriden by overriding the class parameters or by
specifying them in hiera.

```pp
# installs defaults
include vjava

# install Java 9 by default
class {'vjava':
  default_version => 9
}
```

Additionally, if default_version is specified, it will configure the default Java version to use when calling the
Java executable (uses update-java-alternatives on Debian family OSes).

````pp
class {'vjava':
  default_version => 9,
  alternative => 'java-1.9.0-openjdk-amd64',
  alternative_path => '/usr/lib/jvm/java-1.9.0-openjdk-amd64/bin/java'
}
```

You can also specify to set the JAVA_HOME environment variable as well by supplying the java_home parameter.

```pp
class {'vjava':
  java_home => '/usr/lib/jvm/java-1.9.0-openjdk-amd64/'
}
```

`::vjava::java_{x}::jre`

Installs the specific (x) Java JRE package. Package name is configurable as well via parameters or the hiera
lookup (**vjava::java_8::jre::package**).

```pp
# Default Java 8 debug JRE package
include vjava::java_8::jre

# custom package
class{'vjava::java_8::jre':
  package => 'openjdk-8-jre-headless'
}
````

`::vjava::java_{x}::jdk`

Installs the specific (x) Java JDK package. Package name is configurable as well via parameters or the hiera
lookup (**vjava::java_8::jdk::package**).

```pp
# Default Java 8 debug JDK package
include vjava::java_8::jdk

# custom package
class{'vjava::java_8::jdk':
  package => 'openjdk-8-jdk-headless'
}
```

`::vjava::java_{x}::dbg`

Installs the specific (x) Java debug package. Package name is configurable as well via parameters or the hiera
lookup (**vjava::java_8::dbg::package**).

```pp
# Default Java 8 debug package
include vjava::java_8::dbg

# custom package
class{'vjava::java_8::dbg':
  package => 'openjdk-8-dbg-headless'
}
```

`::vjava::java_{x}::doc`

Installs the specific (x) Java documentation package. Package name is configurable as well via parameters or the
hiera lookup (**vjava::java_8::doc::package**).

```pp
# Default Java 8 documentation package
include vjava::java_8::doc

# custom package
class{'vjava::java_8::doc':
  package => 'openjdk-8-doc-headless'
}
```

### Hiera

Most options can be configured via hiera parameters lookup and defaults are provided under hiera folder.

### Facts

Module includes several facts regarding java installation. These are all under the java fact and show the default java
version as well as known installed java versions. The fact is a hash with each installed version being represented as a
hash. The 'default' key only holds the current default java version (from calling `java -version`).

**Example**:

```pp
java {
  default => '8',
  '8' => {
    home => '/usr/lib/jvm/java-8-openjdk-amd64',
    type => 'amd64',
    default => true
  }
  '9' => ...
}
```

## Limitations

Module build against Puppet 5.

Tested on:

- Ubuntu 18.04 LTS
- LinuxMint 19
- Debian 9

## Development

See [CONTRIBUTING.md](CONTRIBUTING.md)

## Release Notes

See [CHANGELOG.md](CHANGELOG.md)
