$(document).on 'page:update', ->
  bounce = ($elem) ->
    $elem.transition { scale: 1.1 }, 160, 'easeOutSine'
         .transition { scale: 1 },   240, 'easeInOutSine'

  bounce $('.flashes')

  focusError = ->  
    $errors = $('form.formtastic .error input')
    if $errors.length > 0
      $errors[0].focus()
      for error in $errors
        bounce $(error)
      $errors.change (e) ->
        $parent = $(e.target).parent('.error')
        $parent.toggleClass('error', false)
        $parent.find('.inline-error').hide()
  setTimeout focusError, 0

  # $('form').on 'ajax:aborted:required', (e, fields) ->
  #   $(fields[0]).focus()

  $('textarea').autogrow()
