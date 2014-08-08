#= require jquery
#= require jquery_ujs
#= require json2
#= require_tree ./common
#= require ./lib/manifest
#= require_tree .

$ ->
  # init tooltips
  $('[data-toggle="tooltip"]').tooltip()

  # UX for "refresh feeds" link
  $('#refresh-feeds').click ->
    $(this).addClass('disabled').attr('disabled', 'disabled')
    $(this).find('i').addClass('fa-spin')


  # mark "read" posts w/ hidden field data (need to do this for "Back Button" UX)
  # (http://stackoverflow.com/questions/16431164/preserve-dynamically-changed-html-on-back-button)
  read_stories_input = $("input[name='read_stories']")

  if read_stories_input.length
    # when we load
    read_story_ids = $.parseJSON(read_stories_input.val())

    for read_story_id in read_story_ids
      $(".story[data-id='#{read_story_id}']").addClass('read')

  # and to stash the data when a story link is followed...
  $("li.story").click (e) ->
    if !e.clickableListIgnore
      read_story_ids = $.parseJSON(read_stories_input.val())

      if !$(this).hasClass('keep-unread')
        read_story_ids.push(parseInt($(this).data('id')))

      read_stories_input.val(JSON.stringify(read_story_ids))

