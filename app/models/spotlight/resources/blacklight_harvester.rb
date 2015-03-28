module Spotlight::Resources
  class BlacklightHarvester < Spotlight::Resources::AtomHarvester
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
      content = Hash[Nokogiri::HTML(x.xpath("atom:content", ns).text).css('dt').map do |dt|
        [dt.text, dt.first.next('dd').text] 
      end].reject { |k,v| k.blank? }
    end
  end
end