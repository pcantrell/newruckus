isPopupVisible = ($button) ->
  $button.hasClass('popup-button-active')

resolvePopup = ($button) ->
  $popup = $('#' + $button.data('show-popup'))
  $header = if $button.data('popup-header')
    $('#' + $button.data('popup-header'))
  else
    $popup.parent()
  [$popup, $header]

curPopupButton = -> $('.popup-button-active')

positionCurPopup = ->
  [$popup, $header] = resolvePopup(curPopupButton())
  if $header?.length > 0
    headerOffset = $header.offset()
    $popup.offset(
      left: Math.max(0, headerOffset.left + $header.outerWidth() - $popup.outerWidth()),
      top:              headerOffset.top  + $header.outerHeight() - 1)

showPopup = ($button, show) ->
  return unless $button
  [$popup, $header] = resolvePopup($button)

  if show
    showPopup(curPopupButton(), false)
  
  $button.toggleClass('popup-button-active', show)

  updateHeaderState = -> $header.toggleClass('popup-header-active', show)
  action = if(show)
    $popup.slideDown(200)
    updateHeaderState()
  else
    $popup.slideUp(200, updateHeaderState)

  if show
    positionCurPopup()

    focus = ->
      $input = $popup.find('input')
      if $input.length > 0
        $input[0].focus()

    minScroll = Math.max(0, $popup.offset().top + 260 - $(window).height())
    if $(document).scrollTop() < minScroll
      $('html, body').animate(scrollTop: minScroll, focus)
    else
      focus()

togglePopup = ($button) ->
  showPopup $button, !isPopupVisible($button)

$ ->
  $(document).on 'click', '[data-show-popup]', (e) ->
    e.preventDefault()
    togglePopup($(e.target))

$(window).resize positionCurPopup
$(window).scroll ->
    setTimeout positionCurPopup, 1
