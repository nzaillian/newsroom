class CreateInitialSchema < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :uuid
      t.string :name
      t.text :url
      t.datetime :last_fetched
      t.string :slug
      t.timestamps
    end

    add_index :feeds, :uuid
    add_index :feeds, :slug
    add_index :feeds, :url
    add_index :feeds, :created_at

    create_table :stories do |t|
      t.string :uuid
      t.integer :feed_id
      t.text :title
      t.text :permalink
      t.text :body
      t.datetime :published
      t.boolean :is_read
      t.boolean :starred
      t.boolean :keep_unread
      t.string :slug
      t.timestamps
    end

    add_index :stories, :uuid
    add_index :stories, :slug
    add_index :stories, :feed_id
    add_index :stories, :published

    create_table :users do |t|
      t.string :email
      t.string :encrypted_password
      t.timestamps
    end
  end
end