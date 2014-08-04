$ ->
  populateSharres = ->
    $('.sharrre').not('.loaded').sharrre
      share:
        twitter: true
        facebook: true
        googlePlus: true
      template: '
        <div class="bubble count-{total}">
          <div class="count">{total}</div>
        </div>
        <div class="buttons">
          <a href="#" class="button twitter">Tweet</a>
          <a href="#" class="button facebook">Like</a>
          <a href="#" class="button googleplus">+1</a>
        </div>'
      render: (api, options) ->
        $.each ['twitter', 'facebook', 'googlePlus'], (i, network) ->
          $(api.element).on 'click', '.sharrre .button.' + network.toLowerCase(), -> api.openPopup network
      enableHover: false
      enableCounter: true
      enableTracking: true
      urlCurl: ''
      shorterTotal: false
    $('.sharrre').addClass 'loaded'
  
  populateSharres()
  $(document).ajaxSuccess populateSharres
