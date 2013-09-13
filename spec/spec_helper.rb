# -*- mode: ruby; coding: utf-8; -*-

require 'rspec/expectations'
require 'chefspec'
require 'chefspec/berkshelf'
# require 'chefspec/server'

at_exit { ChefSpec::Coverage.report! }

# module ChefSpec
# ChefSpec matcher for ark resource
#   module Matchers
#     RSpec::Matchers.define :install_ark do |package_name|
#       match do |chef_run|
#         chef_run.resource_collection.any? do |resource|
#           resource_type(resource) == 'ark' && resource.name == package_name
#         end
#       end
#     end
#   end
# end
