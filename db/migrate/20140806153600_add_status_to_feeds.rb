class AddStatusToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :status, :string
  end
end
