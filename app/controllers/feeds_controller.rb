class FeedsController < ApplicationController
  before_filter :find_feed, only: member_actions

  handles_sortable_columns

  def index
    @feeds = Feed.all.order(created_at: :desc).page(page_param)
  end

  def new
    @feed = Feed.new
  end

  def create
    @feed = Feed.new(feed_params)

    if @feed.save
      flash[:notice] = 'Feed added successfully'
      redirect_to feeds_path
    else
      render :new
    end
  end

  def show
    @stories = @feed.stories.with_feeds.order(stories_sort_order).page(page_param)
  end

  def edit ; end

  def update
    if @feed.update(feed_params)
      redirect_to edit_feed_path(@feed), flash: {notice: 'Feed details successfully updated'}
    else
      render :edit
    end
  end

  def destroy
    @feed.destroy

    redirect_to feeds_path
  end

  private

  def feed_params
    params.permit(feed: [:url, :name])[:feed]
  end

  def find_feed
    @feed = Feed.friendly.find(id_param)
  end

  def stories_sort_order
    sortable_column_order || 'stories.published DESC'
  end  
end