dirty = false
confirmUnload = (callback) ->
  if dirty
    callback 'You will lose your changes.'
  else
    undefined
# Why isn't beforeunload working?
$(window).on   'beforeunload',            -> confirmUnload((msg) -> msg)
$(document).on 'turbolinks:before-visit', -> confirmUnload((msg) -> confirm(msg))

$(document).on 'turbolinks:load', ->
  bounce = ($elem) ->
    $elem.transition { scale: 1.1 }, 160, 'easeOutSine'
         .transition { scale: 1 },   240, 'easeInOutSine'

  bounce $('.flashes')

  dirty = false
  $(document).on 'change, keydown', ':input', ->
    dirty = true
  $(document).on 'submit', 'form', ->
    dirty = false
    true

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
