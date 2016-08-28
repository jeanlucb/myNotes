# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
	$.datepicker.setDefaults({ dateFormat: 'D, M dd, yy, at hh:mm' });

jQuery ->
  $('#to_do_deadline').datetimepicker()
