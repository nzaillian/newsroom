module Feeds
  module Fetching
    extend ActiveSupport::Concern

    included do
      def fetch!
        begin
          parser = Feedjira::Feed
          raw_feed = parser.fetch_and_parse(url, user_agent: 'Newsroom', if_modified_since: (last_fetched || 1.week.ago), timeout: 30, max_redirects: 2)

          if raw_feed == 304
            logger.info "Feed #{url} (id: #{id}) not modified"      
          elsif raw_feed.is_a?(Fixnum)
            logger.error "failed to fetch feed for #{url} (id: #{id}) (encoding error)"  
            update!(status: 'red')
          else
            new_entries_from(raw_feed).each do |entry|
              Story.create_from_raw_feed_entry!(entry, self)
            end
            update!(status: 'green')
          end
        rescue Exception => e
          update!(status: 'red')
          logger.error "failed to fetch feed for #{url} (id: #{id}) (#{e.message})"
        end
      end

      def self.fetch_all!
        Feed.find_each { |feed| feed.fetch! }
      end  

      private
      
      def new_entries_from(raw_feed)
        return [] if raw_feed.last_modified &&
                     raw_feed.last_modified < last_fetched

        stories = []
        raw_feed.entries.each do |story|
          break if latest_entry_id && story.id == latest_entry_id

          stories << story unless story.published &&
                                  story.published < last_fetched
        end

        stories
      end          
    end
  end
end