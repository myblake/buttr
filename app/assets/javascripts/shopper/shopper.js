$('.js-toggle-available').click(function(){
  var $this = $(this),
    url = $this.attr('href');

  $element = $this.parent();
  startWaiting($element);

  $.ajax(url, {
    type: 'put',
    success: function(json) {
      stopWaiting($element, true);
    },
    error: function(){
      stopWaiting($element, false);
    }
  })
  return false;
});

function startWaiting($element){
  var $link = $element.find('a');
  if ($element.hasClass('calendar-unavailable')){
    $element.removeClass('calendar-unavailable');
    $element.data('last-class', 'calendar-unavailable');
  }
  else{
    $element.removeClass('calendar-available');
    $element.data('last-class', 'calendar-available');
  }
  $link.hide();
  $('#loader').clone().attr('id','link-clone' + $link.data('day') + $link.data('time')).addClass('link-clone').removeClass('hidden').insertBefore($link);
}

function stopWaiting($element, success){
  var $link = $element.find('a');
  if (success) {
    toggleAvailability($element);
  }
  else {
    $element.addClass($element.data('last-class'));
  }
  $element.data('last-class', '')
  $('#link-clone' + $link.data('day') + $link.data('time')).remove();
  $link.show();
}

function toggleAvailability($element) {
  if ($element.data('last-class') == 'calendar-unavailable'){
    $element.addClass('calendar-available');
    $element.find('a').text('Mark Unavailable');
  }
  else{
    $element.addClass('calendar-unavailable');
    $element.find('a').text('Mark Available');
  }
}
