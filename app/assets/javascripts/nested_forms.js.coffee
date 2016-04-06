jQuery ->
  $(document).on 'click', 'form .remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('.image-field').hide()
    event.preventDefault()
  $(document).on 'click', 'form .add_fields', (event) ->
    if ($('.remove_fields').size() != 10)
      time = new Date().getTime()
      regexp = new RegExp($(this).data('id'), 'g')
      $(this).before($(this).data('fields').replace(regexp, time))
      event.preventDefault()
    else
      alert('Можно добавить только 10')