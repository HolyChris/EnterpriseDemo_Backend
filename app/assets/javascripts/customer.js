$(document).on('page:change', function(){
  $('body').on('click', 'form.customer .behave_radio1', function(e){
    var selected_siblings = $(this).parents('form').find('.behave_radio1:checked');
    if(selected_siblings.length > 0){
      selected_siblings.not(this).attr('checked', false);
    } else {
      alert('Atleast one should be selected');
      return false;
    }
  });
});