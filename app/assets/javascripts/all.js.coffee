$ ->
  unless (navigator.userAgent.match(/(iPad|iPhone|iPod|Android)/g))

    $window = $(window)
    $document = $(document)

    ease = (x) -> (1 - Math.cos(x * Math.PI)) / 2
    zeroToOne = (x) -> Math.max(0, Math.min(1, x))

    offsetMin = 180
    padMin = 1
    padMax = 8.2

    applyHeroParallax = ->
      padRemoved = 0
      for hero, index in $('.hero')
        $hero = $(hero)
        offset = 0.5 * $document.scrollTop() + offsetMin
        $hero.css('background-position', "0 #{-Math.round(offset)}px")

        pad = padMin + (padMax - padMin) *
          ease(
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
