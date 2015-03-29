require 'spotlight/engine'

module Spotlight
  module Atom
    class Engine < ::Rails::Engine
      Spotlight::Resources::Engine.config.resource_partials = ['spotlight/resources/atom/blacklight', 'spotlight/resources/atom/omeka']
      initializer "spotlight.dor.initialize" do
        Spotlight::Engine.config.resource_providers << Spotlight::Resources::OmekaHarvester
        Spotlight::Engine.config.resource_providers << Spotlight::Resources::BlacklightHarvester
        Spotlight::Engine.config.resource_providers << Spotlight::Resources::AtomHarvester
        Spotlight::Engine.config.new_resource_partials ||= []
        Spotlight::Engine.config.new_resource_partials << 'spotlight/resources/atom/tabbed_form'
      end
    end
  end
end
