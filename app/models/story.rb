class Story < ActiveRecord::Base
  include Common::Uuid, Stories::Parsing, Stories::Filtering

  extend FriendlyId

  friendly_id :uuid, use: :slugged

  belongs_to :feed

  scope :read, -> { where(is_read: true) }

  scope :with_feeds, ->{ preload(:feed) }

  before_save :cancel_is_read, if: -> { keep_unread }

  def self.create_from_raw_feed_entry!(entry, feed)
    Story.create!(feed: feed,
                title: entry.title,
                permalink: entry.url,
                body: extract_content(entry),
                published: entry.published || Time.now,
                entry_id: entry.id)
  end

  def cancel_is_read
    self.is_read = false
    true
  end

  def self.cache_key
    "(#{(all.order(updated_at: :asc).last.try(:cache_key) || 'story-nil')}-#{all.size}"
  end
end