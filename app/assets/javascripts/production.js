$(document).on('page:change', function(){
  $('form.production').on('submit', function(){
    var paid_till_now = $(this).find('#production_paid_till_now').val();
    if(!paid_till_now.match(/\d+/)){
      var valid = confirm('Are you sure to set a production date when no $ is collected?');
      return valid;
    }
  });
});