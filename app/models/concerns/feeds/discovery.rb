module Feeds
  module Discovery
    extend ActiveSupport::Concern

    included do      
      def discover_feed(site_url)
        urls = Feedbag.find(site_url)

        return nil if urls.empty?
        
        urls.first
      end     
      
      def derive_feed_details
        feed_url = discover_feed(url)

        if !feed_url
          errors[:url] << "does not seem to correspond to a valid RSS/Atom feed"
          return false
        else
          parser = Feedjira::Feed
          feed = parser.fetch_and_parse(url, user_agent: "Newsroom")      
          
          if feed == 0
            errors[:url] << "does not seem to correspond to a valid RSS/Atom feed"
            return false        
          end
          
          self.url = feed_url
          self.name ||= feed.title
        end
      end       
    end
  end
end