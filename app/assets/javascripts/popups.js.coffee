$(document).on 'page:change', ->
  $('.popup').hide()
  
  isPopupVisible = (button) ->
    $(button).data('popup-shown')

  showPopup = (button, show) ->
    $(button).data('popup-shown', show)
    $popup = $('#' + $(button).data('show-popup'))
    $header = $('#' + $(button).data('popup-header'))
    
    updateHeaderState = -> $header.toggleClass('popup-shown', show)
    action = if(show)
      $popup.slideDown(200)
      updateHeaderState()
    else
      $popup.slideUp(200, updateHeaderState)

    if $header.length > 0
      headerOffset = $header.offset()
      $popup.offset(
        left: headerOffset.left + $header.outerWidth() - $popup.outerWidth(),
        top:  headerOffset.top  + $header.outerHeight())

  togglePopup = (button) ->
      showPopup button, !isPopupVisible(button)

  for button in $('[data-show-popup]')
    $(button).click (e) ->
      e.preventDefault()
      togglePopup($(button))
