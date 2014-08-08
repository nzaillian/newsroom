class IndexStoriesOnStarred < ActiveRecord::Migration
  def change
    add_index :stories, :starred
  end
end
