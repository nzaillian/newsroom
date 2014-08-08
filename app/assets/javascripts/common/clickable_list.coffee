$ ->
  $('body').on 'click', 'ul.clickable-items li', (e) ->
    if !e.clickableListIgnore
      window.location = $(this).find('.click-target').attr('href')

  $('body').on 'click', 'ul.clickable-items a:not(.click-target)', (e) ->
    e.clickableListIgnore = true