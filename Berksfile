# -*- mode: ruby; coding: utf-8; -*-

source 'https://api.berkshelf.com'

metadata

cookbook 'ark', '~> 0.8.2'

group :integration do
  cookbook 'apt'
  cookbook 'yum'
  cookbook 'java'
  cookbook 'tomcat_test_basic_lwrp', path: 'test/fixtures/cookbooks/tomcat_test_basic_lwrp'
end
