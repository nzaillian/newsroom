class Feed < ActiveRecord::Base
  include Common::Uuid, Feed::Discovery, Feed::Fetching

  extend FriendlyId

  friendly_id :uuid

  has_many :stories, dependent: :destroy

  validates :url, presence: true, uniqueness: true

  after_initialize :init

  # see app/models/concerns/feed/discovery.rb
  before_save :derive_feed_details, if: ->{ url_changed? }  

  def to_param
    uuid
  end  

  private

  def latest_entry_id
    return stories.order(published: :asc).last.entry_id unless stories.empty?
  end  

  def init
    self.last_fetched = 4.months.ago if last_fetched.nil?
  end
end