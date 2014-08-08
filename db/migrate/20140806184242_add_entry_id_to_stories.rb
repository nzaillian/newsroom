class AddEntryIdToStories < ActiveRecord::Migration
  def change
    add_column :stories, :entry_id, :text
  end
end
