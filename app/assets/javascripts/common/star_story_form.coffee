class StarStoryForm
  constructor: (@form) ->
    @check_box = @form.find('.starred-checkbox')
    @star_link = @form.find('a.star-story')

    @star_link.click @toggle_starred

  toggle_starred: (e) =>
    e.preventDefault()

    @star_link.toggleClass('starred')

    starred_state = @star_link.hasClass('starred')

    @check_box.prop('checked', starred_state)

    $.ajax
      type: 'PUT'
      url: @form.attr('action')
      data: @form.serialize()

    li = @star_link.parents('li.story')
    
    if li.length
      if starred_state == true
        li.addClass('starred')
      else
        li.removeClass('starred')


$ ->
  $('.star-form').each ->
    new StarStoryForm($(this))