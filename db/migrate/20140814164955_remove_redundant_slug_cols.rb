class RemoveRedundantSlugCols < ActiveRecord::Migration
  def change
    remove_column :feeds, :slug
    remove_column :stories, :slug
  end
end
