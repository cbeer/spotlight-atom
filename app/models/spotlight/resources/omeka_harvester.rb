module Spotlight::Resources
  class OmekaHarvester < Spotlight::Resources::AtomHarvester
    def convert_entry_to_solr_hash x
      content = atom_content_to_hash(x)
      create_sidecars_for(*content.keys)
      h = {}
      
      content.each_with_object(h) do |(key, value), hash|
        h[exhibit_custom_field[key].field] = value
      end

      super.merge h
    end

    def atom_content_to_hash x
      content = Hash[Nokogiri::HTML(x.xpath("atom:content", ns).text).css('.element').map do |d| 
        [d.css('h3').text, d.css('.element-text').text] 
      end].reject { |k,v| k.blank? }
    end

    def create_sidecars_for *keys
      missing = keys - exhibit.custom_fields.map { |x| x.label }

      missing.each do |k|
        exhibit.custom_fields.create! label: k
      end.tap { @exhibit_custom_field = nil }
    end

    def exhibit_custom_field
      @exhibit_custom_field ||= exhibit.custom_fields.each_with_object({}) do |value, hash|
        hash[value.label] = value
      end
    end

  end
end