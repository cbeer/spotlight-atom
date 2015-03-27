module Spotlight::Resources
  class AtomHarvester < Spotlight::Resource
    self.weight = -5000

    after_save :harvest_resources
    
    def self.can_provide? res
      is_atom?(res.url) || !!(res.url =~ /.atom/)
    end

    def self.is_atom? url
      Faraday.head(url) do |req|
        req.headers['Accept'] = 'application/atom+xml'
      end.status == 200
    end
   
    def update_index data
      data = [data] unless data.is_a? Array
      blacklight_solr.update params: { commitWithin: 500 }, data: data.to_json, headers: { 'Content-Type' => 'application/json'} unless data.empty?
    end
   
    def to_solr
      []
    end

    def harvest_resources
      items.each do |x|
        h = convert_entry_to_solr_hash(x)
        puts "creating #{h.inspect}"
        Spotlight::Resources::Upload.create(
          remote_url_url: h[:url],
          data: h,
          exhibit: exhibit
        ) if h[:url]
      end
    end

    def items
      return enum_for(:items) unless block_given?

      doc = fetch(self.url)
      while doc and doc.xpath('//atom:entry', ns).any?
        h = doc.xpath('//atom:entry', ns).map do |x|
          yield x
        end

        if doc.xpath('/atom:feed/atom:link[@rel="next"]', ns).any?
          doc = fetch(doc.xpath('/atom:feed/atom:link[@rel="next"]', ns).first.attr('href'))
        else
          doc = nil
          break
        end
      end
    end

    def convert_entry_to_solr_hash x  
      { 
        exhibit.blacklight_config.document_model.unique_key.to_sym => compound_id(x),
        title_field => x.xpath('atom:title', ns).text, 
        url: x.xpath('atom:link[contains(@rel, "enclosure")]/@href', ns).text
      }
    end

    def compound_id x
      x.xpath("atom:id", ns).text.parameterize
    end

    def fetch url
      Nokogiri::XML(Faraday.get(url) do |req|
        req.headers['Accept'] = 'application/atom+xml'
      end.body)
    end

    def ns
      { atom: "http://www.w3.org/2005/Atom" }
    end

    def title_field
      Spotlight::Engine.config.upload_title_field || exhibit.blacklight_config.index.title_field
    end
  end
end