#= require active_admin/base
#= require best_in_place
#= require best_in_place.purr
#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require jquery-ui
#= require jquery.tagsinput
#= require chosen.jquery.min
#= require jquery.datetimepicker
#= require autocomplete-rails
#= require managers_autocomplete

$(document).on "ready, page:change", ->
  jQuery(".best_in_place").best_in_place();
  jQuery(".timepicker").datetimepicker({
    datepicker:false,
    step:30,
    format:'H:i'
  });
