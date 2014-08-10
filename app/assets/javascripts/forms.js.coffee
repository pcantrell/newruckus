$(document).on 'page:update', ->
  
  $errors = $('form.formtastic .error input')
  if $errors.length > 0
    $errors[0].focus()
    for error in $errors
      $(error).transition { scale: 1.1 }, 160, 'easeOutSine'
              .transition { scale: 1 },   240, 'easeInOutSine'
    $errors.change (e) ->
      $parent = $(e.target).parent('.error')
      $parent.toggleClass('error', false)
      $parent.find('.inline-error').hide()

  # $('form').on 'ajax:aborted:required', (e, fields) ->
  #   $(fields[0]).focus()

  $('textarea').autogrow()
