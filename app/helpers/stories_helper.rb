module StoriesHelper
  def story_classes(story)
    classes = []

    classes << 'read' if story.is_read

    classes << 'unread' if !story.is_read

    classes << 'keep-unread' if story.keep_unread

    classes << 'starred' if story.starred

    classes.join(' ')
  end
end