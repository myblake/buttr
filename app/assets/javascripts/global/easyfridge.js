$(function() {
  $('.datepicker').datepicker();
  $('.dropdown-toggle').dropdown();
  $('.formatted-phone').keyup(function(){
    formatPhone(this);
  });
});

function formatPhone(element) {
  var $element = $(element);
  var start = element.selectionStart,
      end = element.selectionEnd,
      startLength = $element.val().length;

  // format number
  $element.val(formatLocal("US", $element.val()));

  var endLength = $element.val().length;

  // if length doens't change, don't move cursor
  if (startLength === endLength) {
    element.setSelectionRange(start, end);
  }
  // if the formatter changes the length just shoot user to the end
  else {
    element.setSelectionRange(endLength, endLength);
  }
}
