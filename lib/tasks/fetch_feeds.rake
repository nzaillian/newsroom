task fetch_feeds: :environment do
  Feed.fetch_all!
end