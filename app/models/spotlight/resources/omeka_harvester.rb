module Spotlight::Resources
  class OmekaHarvester < Spotlight::Resources::AtomHarvester
    def convert_entry_to_solr_hash x
      content = atom_content_to_hash(x)
      create_sidecars_for(*content.keys)
      h = {}
      
      content.each_with_object(h) do |(key, value), hash|
        h[exhibit_custom_fields[key].field] = value
      end

      super.merge h
    end

    def atom_content_to_hash x
      content = Hash[Nokogiri::HTML(x.xpath("atom:content", ns).text).css('.element').map do |d| 
        [d.css('h3').text, d.css('.element-text').text] 
      end].reject { |k,v| k.blank? }
    end

  end
end