# -*- mode: ruby; coding: utf-8; -*-
#
# Cookbook Name:: tomcat
# Attributes:: default
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

default['tomcat']['prefix_dir'] = '/usr/local'
default['tomcat']['prefix_root'] = "#{node['tomcat']['prefix_dir']}/tomcat"
default['tomcat']['home_dir'] = "#{node['tomcat']['prefix_root']}/default"

default['tomcat']['instance_default']['release'] = '7.0.54'
default['tomcat']['instance_default']['checksum'] = 'c26ae0bc424e2639f5c77eb4d274a026c5a584a404dbdbb247ab6d2c3ebe8258'

default['tomcat']['instance_default']['prefix_user'] = 'tomcat'
default['tomcat']['instance_default']['prefix_user_id'] = '12'
default['tomcat']['instance_default']['prefix_group'] = 'tomcat'
default['tomcat']['instance_default']['prefix_group_id'] = '12'

default['tomcat']['instance_default']['shutdown_port'] = '8005'
default['tomcat']['instance_default']['http_port'] = '8080'

default['tomcat']['instance_default']['context_path'] = '/'
default['tomcat']['instance_default']['doc_base'] = ''
