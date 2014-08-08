class KeepUnreadForm
  constructor: (@form) ->
    @check_box = @form.find('.keep-unread-checkbox')

    @check_box.change =>
      $.ajax
        type: 'PUT'
        url: @form.attr('action')
        data: @form.serialize()

$ ->
  $('.keep-unread-form').each ->
    new KeepUnreadForm($(this))