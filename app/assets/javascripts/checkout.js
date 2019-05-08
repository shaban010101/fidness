$(document).ready(function() {
  $("select").ready(function() {
    var selected = $('#option').find(':selected');
    var price = selected.data('price');
    var sessionPrice = selected.data('session-cost');
                     
    $('.total-price').empty();
    $('.total-price').append("Total price: £" + price + " / " + sessionPrice + " per session");
  });

  $("select").change(function() {
    var selected = $('#option').find(':selected');
    var price = selected.data('price');
    var sessionPrice = selected.data('session-cost');
                     
    $('.total-price').empty();
    $('.total-price').append("Total price: £" + price + " / " + sessionPrice + " per session");
  });
});

