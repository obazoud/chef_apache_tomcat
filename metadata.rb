# -*- mode: ruby; coding: utf-8; -*-

name 'tomcat'
maintainer 'Olivier Bazoud'
maintainer_email 'olivier.bazoud@gmail.com'
license 'Apache 2.0'
description 'Installs and configures tomcat instances'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'

depends 'ark'

supports 'ubuntu'
supports 'centos'
