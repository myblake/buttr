$('.js-toggle-available').click(function(){
  var $this = $(this),
    url = $this.attr('href');
  $.ajax(url, {
    type: 'put',
    success: function(json) {
      console.log(json);
      toggleAvailability($this.parent());
    },
    error: function(){
      console.log('error');
    }
  })
  return false;
});

function toggleAvailability($element) {
  if ($element.hasClass('calendar-unavailable')){
    $element.removeClass('calendar-unavailable');
    $element.addClass('calendar-available');
    $element.find('a').text('Mark Unavailable');
  }
  else{
    $element.removeClass('calendar-available');
    $element.addClass('calendar-unavailable');
    $element.find('a').text('Mark Available');
  }
}
