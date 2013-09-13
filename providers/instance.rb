# -*- mode: ruby; coding: utf-8; -*-
#
# Cookbook Name:: tomcat
# Provider:: instance
# Author:: Olivier Bazoud (<olivier.bazoud@gmail.com>)
#
# Copyright 2014, Olivier Bazoud
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

action :install do
  new_resource.release ||= node['tomcat']['instance_default']['release']
  new_resource.major_version ||= new_resource.release[0, 1]

  new_resource.home ||= "#{node['tomcat']['prefix_root']}/tomcat-#{new_resource.release}"
  new_resource.base ||= "#{node['tomcat']['prefix_root']}/#{new_resource.name}"

  new_resource.url  ||= 'http://archive.apache.org/dist/tomcat' \
    "/tomcat-#{new_resource.major_version}" \
    "/v#{new_resource.release}" \
    "/bin/apache-tomcat-#{new_resource.release}.tar.gz"
  new_resource.checksum ||= node['tomcat']['instance_default']['checksum']

  new_resource.user  ||= "#{node['tomcat']['instance_default']['prefix_user']}#{new_resource.major_version}"
  new_resource.user_id  ||= "#{node['tomcat']['instance_default']['prefix_user_id']}#{new_resource.major_version}".to_i
  new_resource.group  ||= "#{node['tomcat']['instance_default']['prefix_user']}#{new_resource.major_version}"
  new_resource.group_id  ||= "#{node['tomcat']['instance_default']['prefix_group_id']}#{new_resource.major_version}".to_i

  new_resource.shutdown_port ||= node['tomcat']['instance_default']['shutdown_port']
  new_resource.http_port ||= node['tomcat']['instance_default']['http_port']

  new_resource.context_path ||= node['tomcat']['instance_default']['context_path']
  new_resource.doc_base ||= node['tomcat']['instance_default']['doc_base']

  template_dir = "tomcat#{new_resource.major_version}"

  group new_resource.group do
    gid new_resource.group_id
  end

  user new_resource.user do
    comment "Apache Tomcat Instance user #{new_resource.user}"
    gid new_resource.group_id
    uid new_resource.user_id
  end

  directory node['tomcat']['prefix_root'] do
    owner new_resource.user
    group new_resource.group
  end

  ark 'tomcat' do
    url new_resource.url
    version new_resource.release
    checksum new_resource.checksum
    prefix_root node['tomcat']['prefix_root']
    home_dir node['tomcat']['home_dir']
    owner
  end

  %w(bin conf lib logs temp webapps work).each do |dir|
    directory "#{new_resource.base}/#{dir}" do
      recursive true
      user new_resource.user
      group new_resource.group
    end
  end

  template "#{new_resource.base}/README" do
    cookbook 'tomcat'
    source "#{template_dir}/README.erb"
    owner new_resource.user
    group new_resource.user
    mode '0644'
    variables(tomcat: new_resource)
    action :create
  end

  template "#{new_resource.base}/conf/server.xml" do
    cookbook 'tomcat'
    source "#{template_dir}/server.xml.erb"
    owner new_resource.user
    group new_resource.user
    mode '0644'
    variables(tomcat: new_resource)
    action :create
  end

  template "#{new_resource.base}/conf/web.xml" do
    cookbook 'tomcat'
    source "#{template_dir}/web.xml.erb"
    owner new_resource.user
    group new_resource.user
    mode '0644'
    variables(tomcat: new_resource)
    action :create
  end

  template "#{new_resource.base}/bin/setenv.sh" do
    cookbook 'tomcat'
    source "#{template_dir}/setenv.sh.erb"
    owner new_resource.user
    group new_resource.user
    mode '0754'
    variables(tomcat: new_resource)
    action :create
  end

  template "/etc/init.d/#{new_resource.name}" do
    cookbook 'tomcat'
    source "#{template_dir}/init.d.erb"
    owner 'root'
    group 'root'
    mode '0754'
    variables(tomcat: new_resource)
    action :create
  end

  service new_resource.name do
    service_name new_resource.name
    supports restart: true, reload: true, status: true
    action [:enable, :start]
    subscribes :restart, "
      template[#{new_resource.base}/conf/server.xml],
      template[#{new_resource.base}/bin/setenv.sh],
      template[/etc/init.d/#{new_resource.name}]"
  end

  new_resource.updated_by_last_action(true)

end

action :remove do
end

action :purge do
end
