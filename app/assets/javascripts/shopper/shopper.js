$('.js-toggle-available.availability').change(function(){
  var $this = $(this),
    url = $this.data('url'),
    level = $this.val(),
    $element = $this.parent();
  startWaiting($element);

  $.ajax(url, {
    type: 'put',
    data: {
      day: $this.data('day'),
      time: $this.data('time'),
      zone: $this.parent().find('select.zone').val(),
      level: level
    },
    success: function(json) {
      stopWaiting($element, true, json['object']['level']);
    },
    error: function(){
      stopWaiting($element, false, '');
    }
  })
  return false;
});

$('.js-toggle-available.zone').change(function(){
  $(this).parent().find('select.availability').change();
})

function startWaiting($element){
  var $select = $element.find('select.availability');
  var value = $element.find('option').val();
  var cssclass = $element.attr('class');
  $element.removeClass(cssclass);
  $element.data('last-class', cssclass);
  $element.find('select').hide();
  $('#loader').clone().attr('id','link-clone' + $select.data('day') + $select.data('time')).addClass('link-clone').removeClass('hidden').insertBefore($select);
}

function stopWaiting($element, success, newclass){
  var $select = $element.find('select.availability');
  if (success) {
    $element.addClass('calendar-' + newclass);
  }
  else {
    $element.addClass($element.data('last-class'));
  }
  $element.data('last-class', '')
  $('#link-clone' + $select.data('day') + $select.data('time')).remove();
  $element.find('select').show();
}
