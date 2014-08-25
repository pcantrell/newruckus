#= require active_admin/base
#= require jquery.autogrow-textarea

$ ->
  $('textarea').autogrow()

  $('.schedule .presenter .status').click (e) ->
    event_id = $(e.target).closest('.status').data('composer-night-id')
    signup_href = $(e.target).parent('tr').find('.presenter').find('a').attr('href')
    document.location = signup_href + '?assign_composer_night_id=' + event_id

  $('.expandable').click (e) ->
    $(e.target).closest('.expandable').toggleClass('expanded')
