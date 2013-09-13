# -*- mode: ruby; coding: utf-8; -*-
require 'serverspec'

include SpecInfra::Helper::Exec
include SpecInfra::Helper::DetectOS

describe package('tomcat6') do
  it { should_not be_installed }
end

describe package('tomcat7') do
  it { should_not be_installed }
end

describe user('tomcat7') do
  it { should exist }
end

describe group('tomcat7') do
  it { should exist }
end

describe file('/etc/init.d/mytomcat') do
  it {
    should be_file
    should be_owned_by 'root'
    should be_grouped_into 'root'
    should be_mode 754
  }
end

describe file('/usr/local/tomcat/mytomcat/README') do
  it {
    should be_file
    should be_owned_by 'tomcat7'
    should be_grouped_into 'tomcat7'
    should be_mode 644
  }
end

describe service('mytomcat') do
  it { should be_enabled   }
  it { should be_running   }
end

describe command('/bin/ps aux | grep tomcat') do
  it { should return_exit_status 0 }
end

describe command('/bin/ps -p `sudo /bin/cat /var/run/mytomcat.pid`') do
  it { should return_exit_status 0 }
end

describe port(8080) do
  it { should be_listening }
end
