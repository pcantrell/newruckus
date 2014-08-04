$(document).on 'page:update', ->
  
  $errors = $('form.formtastic .error input')
  if $errors.length > 0
    $errors[0].focus()
    $(document).scrollTop($errors.offset().top - 100)

  # $('form').on 'ajax:aborted:required', (e, fields) ->
  #   $(fields[0]).focus()
