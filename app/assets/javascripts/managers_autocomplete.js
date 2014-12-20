$(document).ready(function() {
  $('#site_manager_ids').chosen({
    width: '100%'
  });
});

$(document).on('ready page:change', function(){
  $('#site_manager_ids').chosen({
    width: '100%'
  });
});