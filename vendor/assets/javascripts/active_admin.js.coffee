#= require active_admin/base
#= require admin/jquery.flot.min
#= require admin/jquery.flot.pie
ready = ->
  $('#' + $(".polyselect").val() + '_poly').show()
  $(".polyselect").on "change", ->
    $('.polyform').hide()
    $('#' + $(@).val() + '_poly').show()

  $('.polyform').first().parent('form').on "submit", (e) ->
    $('.polyform').each (index, element) =>
      $e = $(element)
      if $e.css('display') != 'block'
        $e.remove()

$(document).ready(ready)
$(document).on('page:load', ready)