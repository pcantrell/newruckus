isPopupVisible = ($button) ->
  $button.data('popup-header-active')

positionCurPopup = ->
  $popup  = document.curPopup?.$popup
  $header = document.curPopup?.$header
  if $header?.length > 0
    headerOffset = $header.offset()
    $popup.offset(
      left: Math.max(0, headerOffset.left + $header.outerWidth() - $popup.outerWidth()),
      top:              headerOffset.top  + $header.outerHeight())

showPopup = ($button, show) ->
  return unless $button

  $button.data('popup-header-active', show)
  $popup = $('#' + $button.data('show-popup'))
  $header = if $button.data('popup-header')
    $('#' + $button.data('popup-header'))
  else
    $popup.parent()

  if !show && document.curPopup?.$button[0] == $button[0]
    delete document.curPopup

  if show
    showPopup(document.curPopup?.$button, false)
    document.curPopup =
      $popup:  $popup,
      $button: $button,
      $header: $header

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

$(document).on 'page:change', ->
  for button in $('[data-show-popup]')
    $(button).click (e) ->
      e.preventDefault()
      togglePopup($(e.target))

$(window).resize positionCurPopup
$(window).scroll ->
    setTimeout positionCurPopup, 1
