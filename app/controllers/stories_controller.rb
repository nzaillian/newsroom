class StoriesController < ApplicationController
  before_filter :find_story, only: member_actions

  handles_sortable_columns

  helper_method :filter_params

  def index
    @stories = Story.filter(filter_params).with_feeds.order(sort_order).page(page_param)
  end

  def show
    @story.update!(is_read: true)
  end

  def update
    if @story.update(story_params)
      render json: {status: :success}
    else
      render json: {errors: @story.errors.full_messages}, status: 422
    end
  end

  def refresh
    Feed.fetch_all!

    redirect_to stories_path, flash: {notice: "Feeds refreshed"}
  end

  private

  def sort_order
    sortable_column_order || 'stories.published DESC'
  end

  def find_story
    @story = Story.friendly.find(id_param)
  end  

  def story_params
    params.permit(story: [:starred, :keep_unread, :is_read])[:story]
  end

  def filter_params
    params.permit(filters: [:starred])[:filters]
  end
end