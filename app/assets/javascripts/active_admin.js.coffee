#= require active_admin/base
#= require jquery.autogrow-textarea

$ ->
  $('textarea').autogrow()
  $('.expandable').click (e) ->
    $(e.target).toggleClass('expanded')
    console.log e.target
