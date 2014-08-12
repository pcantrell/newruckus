$ ->
  $(document).on 'change', 'body.signups .date-preference input', (e) ->
    $input = $(e.target)
    $group = $input.parents('.date-preference')
    
    $group.find('.status-message').hide()
    $group.find('.status').removeClass('active')

    status = $input.val()
    $group.find(".status-message.#{status}").show()
    $input.parents('.status').addClass('active')
