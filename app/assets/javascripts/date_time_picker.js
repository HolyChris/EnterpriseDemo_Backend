$(document).on('ready page:change', function(){
  $(".datetimepicker").each(function(){
    $(this).datetimepicker({
      step: 15,
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