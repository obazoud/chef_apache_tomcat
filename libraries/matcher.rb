# -*- mode: ruby; coding: utf-8; -*-

if defined?(ChefSpec)
  ChefSpec::Runner.define_runner_method :tomcat_instance

  def install_tomcat_instance(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:tomcat_instance, :install, resource_name)
  end

  def remove_tomcat_instance(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:tomcat_instance, :remove, resource_name)
  end
end
