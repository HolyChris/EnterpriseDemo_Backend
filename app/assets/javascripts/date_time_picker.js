$(document).on('page:change', function(){
  $(".datetimepicker").each(function(){
    $(this).datetimepicker({
      step: 60,
      format: 'M d Y, h:i a',
      formatDate: 'M d Y',
      formatTime: 'h:i a'
    });
  });

  $('.has_many_container.follow_ups').on('has_many_add:after', function(e, fieldset, container){
    $(fieldset).find('.datetimepicker').datetimepicker({
      step: 60,
      format: 'M d Y, h:i a',
      formatDate: 'M d Y',
      formatTime: 'h:i a'
    });
  });

  $(".timepicker").datetimepicker({
    datepicker: false,
    step: 15,
    format: 'h:i a',
    formatTime: 'h:i a'
  });
});