# -*- mode: ruby; coding: utf-8; -*-
#
# Cookbook Name:: tomcat
# Resource:: instance
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

actions :install, :remove, :purge

attr_accessor :user
attr_accessor :user_id
attr_accessor :group
attr_accessor :group_id

attribute :user, kind_of: String
attribute :user_id, kind_of: Integer
attribute :group, kind_of: String
attribute :group_id, kind_of: Integer

attr_accessor :url
attr_accessor :checksum
attr_accessor :release
attr_accessor :major_version

attribute :url, kind_of: String
attribute :checksum, kind_of: String
attribute :release, kind_of: String
attribute :major_version, kind_of: String

attr_accessor :home
attr_accessor :base
attr_accessor :java_home

attribute :home, kind_of: String
attribute :base, kind_of: String
attribute :java_home, kind_of: String

attr_accessor :shutdown_port
attr_accessor :http_port
attr_accessor :context_path
attr_accessor :doc_base

attribute :http_port, kind_of: Integer
attribute :shutdown_port, kind_of: Integer
attribute :context_path, kind_of: String
attribute :doc_base, kind_of: String

def initialize(*args)
  super
  @action = :install
end
