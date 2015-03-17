$(document).ready(function(){
  $(".datetimepicker").each(function(){
    var that = $(this);
    var val = that.val();
    console.log(val);
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