$ ->
  $window = $(window)
  $document = $(document)

  if (navigator.userAgent.match(/(iPad|iPhone|iPod|Android)/g))
    $('.hero').css('background-attachment', 'scroll')
    $('.hero').css('background-position', 'top left')
  else
    easeIn    = (x) -> Math.pow(-Math.cos(Math.PI / 2 * (x + 1)), 2.5)
    easeInOut = (x) -> (1 - Math.cos(x * Math.PI)) / 2
    zeroToOne = (x) -> Math.max(0, Math.min(1, x))

    offsetMin = 60
    padMin = 1
    padMax = 8.2

    applyHeroParallax = ->
      padRemoved = 0
      for hero, index in $('.hero')
        $hero = $(hero)
        offset = 0.5 * $document.scrollTop() + offsetMin
        $hero.css('background-position', "0 #{-Math.round(offset)}px")

        if $hero.hasClass('compaction')
          pad = padMin + (padMax - padMin) *
            (if index == 0 then easeIn else easeInOut)(
              zeroToOne(
                1 - $document.scrollTop() / 240 + index * 0.5))
          padVal = "#{pad}em"
          for padAttr in ['padding-top', 'padding-bottom']
            if $hero.css(padAttr) != padVal
              $hero.css(padAttr, padVal)

          if $hero.data('original-height')
            padRemoved += $hero.data('original-height') - $hero.outerHeight()
          else
            $hero.data('original-height', $hero.outerHeight())

      $('body').css('padding-bottom', "#{padRemoved}px")

    applyHeroParallax()
    $window.scroll applyHeroParallax
    $document.on 'page:change', applyHeroParallax
