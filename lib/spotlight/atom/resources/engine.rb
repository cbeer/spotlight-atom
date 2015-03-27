require 'spotlight/engine'

module Spotlight
  module Atom
    module Resources
      class Engine < ::Rails::Engine
        
        initializer "spotlight.dor.initialize" do
          Spotlight::Engine.config.resource_providers << Spotlight::Resources::OmekaHarvester
          Spotlight::Engine.config.resource_providers << Spotlight::Resources::AtomHarvester
        end
      end
    end
  end
end
