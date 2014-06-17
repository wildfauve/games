form = "<%= escape_javascript(render(:partial => 'form')) %>"
$('#new_hand').slideUp('slow')
$('#new_hand').html(form)
$('#new_hand').slideDown('slow')