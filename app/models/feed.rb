class Feed < ActiveRecord::Base
  include Common::Uuid, Feeds::Discovery, Feeds::Fetching

  extend FriendlyId

  friendly_id :uuid, use: :slugged

  has_many :stories, dependent: :destroy

  validates :url, presence: true, uniqueness: true

  after_initialize :init

  private

  def latest_entry_id
    return stories.order(published: :asc).last.entry_id unless stories.empty?
  end  

  def init
    self.last_fetched = 1.week.ago if last_fetched.nil?
  end
end