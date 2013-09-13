# -*- mode: ruby; coding: utf-8; -*-
require 'spec_helper'

describe 'tomcat_test_basic_lwrp::default on ubuntu 14.04' do
  let(:chef_run) do
    ChefSpec::Runner.new(
      platform: 'ubuntu',
      version: '14.04',
      step_into: ['tomcat_instance']
    ) do |node|
      node.set['tomcat']['xxx'] = 'xxx'
    end.converge('tomcat_test_basic_lwrp::default')
  end

  context 'when using default lwrp' do
    it 'use tomcat_instance' do
      expect(chef_run).to install_tomcat_instance('mytomcat')
    end

    it 'creates a group and a user' do
      expect(chef_run).to create_group('tomcat7')
        .with_gid(127)
      expect(chef_run).to create_user('tomcat7')
        .with_uid(127)
        .with_gid(127)
    end

    it 'creates root directory' do
      expect(chef_run).to create_directory('/usr/local/tomcat')
        .with_user('tomcat7')
        .with_group('tomcat7')
    end

    it 'downloads and installs tomcat home' do
      # expect(chef_run).to create_ark('tomcat')
    end

    it 'create directories tree' do
      expect(chef_run).to create_directory('/usr/local/tomcat/mytomcat/bin')
        .with_user('tomcat7')
        .with_group('tomcat7')
      expect(chef_run).to create_directory('/usr/local/tomcat/mytomcat/conf')
        .with_user('tomcat7')
        .with_group('tomcat7')
      expect(chef_run).to create_directory('/usr/local/tomcat/mytomcat/lib')
        .with_user('tomcat7')
        .with_group('tomcat7')
      expect(chef_run).to create_directory('/usr/local/tomcat/mytomcat/logs')
        .with_user('tomcat7')
        .with_group('tomcat7')
      expect(chef_run).to create_directory('/usr/local/tomcat/mytomcat/temp')
        .with_user('tomcat7')
        .with_group('tomcat7')
      expect(chef_run).to create_directory('/usr/local/tomcat/mytomcat/webapps')
        .with_user('tomcat7')
        .with_group('tomcat7')
      expect(chef_run).to create_directory('/usr/local/tomcat/mytomcat/work')
        .with_user('tomcat7')
        .with_group('tomcat7')
    end

    it 'puts README file' do
      expect(chef_run).to create_template('/usr/local/tomcat/mytomcat/README')
        .with_path('/usr/local/tomcat/mytomcat/README')
        .with_owner('tomcat7')
        .with_group('tomcat7')
      expect(chef_run).to render_file('/usr/local/tomcat/mytomcat/README')
        .with_content(/Hello, I am the 'mytomcat' instance of Tomcat \'7\'/)
    end

    it 'puts server.xml file' do
      expect(chef_run).to create_template('/usr/local/tomcat/mytomcat/conf/server.xml')
        .with_path('/usr/local/tomcat/mytomcat/conf/server.xml')
        .with_owner('tomcat7')
        .with_group('tomcat7')
      expect(chef_run).to render_file('/usr/local/tomcat/mytomcat/conf/server.xml')
        .with_content(/Server port=\"8005\"/)
        .with_content(/Connector port=\"8080\"/)
        .with_content(/<Context path=\"\/\" docBase=\"\"/)
    end

    it 'puts setenv.sh file' do
      expect(chef_run).to create_template('/usr/local/tomcat/mytomcat/bin/setenv.sh')
        .with_path('/usr/local/tomcat/mytomcat/bin/setenv.sh')
        .with_owner('tomcat7')
        .with_group('tomcat7')
      expect(chef_run).to render_file('/usr/local/tomcat/mytomcat/bin/setenv.sh')
        .with_content(/-Xms512m/)
        .with_content(/-Xmx512m/)
    end

    it 'puts web.xml file' do
      expect(chef_run).to create_template('/usr/local/tomcat/mytomcat/conf/web.xml')
        .with_path('/usr/local/tomcat/mytomcat/conf/web.xml')
        .with_owner('tomcat7')
        .with_group('tomcat7')
      expect(chef_run).to render_file('/usr/local/tomcat/mytomcat/conf/web.xml')
        .with_content(/web-app_3_0.xsd/)
    end

    it 'puts mytomcat init.d file' do
      expect(chef_run).to create_template('/etc/init.d/mytomcat')
        .with_path('/etc/init.d/mytomcat')
        .with_owner('root')
        .with_group('root')
      expect(chef_run).to render_file('/etc/init.d/mytomcat')
        .with_content(/NAME=mytomcat/)
        .with_content(/TOMCAT7_USER=tomcat7/)
        .with_content(/TOMCAT7_GROUP=tomcat7/)
    end

    it 'service mytomcat' do
      expect(chef_run).to start_service 'mytomcat'
      expect(chef_run).to enable_service 'mytomcat'
    end

  end

end
