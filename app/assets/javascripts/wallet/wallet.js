$(function(){
  $('#transaction_amount').change(function(){$this = $(this); val = $this.val();  $this.val(accounting.formatMoney(val, '')); });  
});