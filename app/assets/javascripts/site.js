function toggle_bill_address(ele){
  if($(ele).is(':checked')){
    $('li[id^=site_bill_address_attributes_]').hide();
  } else {
    $('li[id^=site_bill_address_attributes_]').show();
  }
}

$(document).on('ready page:change', function(){
  toggle_bill_address($('#bill_addr_same_as_addr_check'));

  $('#bill_addr_same_as_addr_check').on('change', function(){
    toggle_bill_address(this);
  });
})