$ ->
  showDatePreference = ($input) ->
    $group = $input.parents('.date-preference')
    
    $group.find('.status-message').hide()
    $group.find('.status').removeClass('active')

    status = $input.val()
    $group.find(".status-message.#{status}").show()
    $input.parents('.status').addClass('active')

  $(document).on 'page:change', ->
    $('.status-message.unknown').show()
    for input in $('.status input:checked')
      showDatePreference $(input)
    null

  $(document).on 'change', 'body.signups .date-preference input', (e) ->
    showDatePreference $(e.target)
