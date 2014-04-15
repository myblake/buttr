$(function(){
  $('#customer_shopper_id').change(function(){
    newVal = $(this).val();
    $('#customer_shopping_time_attributes_shopper_id').val(newVal);
  });
  $('#customer_shopper_id').trigger('change');
});
