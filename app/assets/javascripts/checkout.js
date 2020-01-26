$(document).ready(function() {
  var elements = stripe.elements();
  var card = elements.create('card');
  var clientSecret = null;

  card.mount('#card-element');

  card.addEventListener('change', function(event) {
    var displayError = document.getElementById('card-errors');
    if (event.error) {
      displayError.textContent = event.error.message;
    } else {
      displayError.textContent = '';
    }
  });
 
  function changePrice() {
    var selected = $('#option').find(':selected');
    var price = selected.data('price');
    var sessionPrice = selected.data('session-cost');
                     
    $('.total-price').empty();
    $('input#client_secret').remove();
    var trainerId = $('input#trainer_id').val();
    var clientSecret = $.post('/payment_intent', 
                         { 
                           trainer_id: trainerId, 
                           option_id: $('#option').find(':selected')[0].value}).then(function(response) {
                             
        $("<input />").attr("type", "hidden")
          .attr("name", "client_secret")
          .attr("value", response.client_secret)
          .attr("id", 'client_secret')                   
          .appendTo("#payment-form");                     
    });
    
    $('.total-price').append("Total price: £" + price + " / " + sessionPrice + " per session");
  }
  
  $('#myModal').on('show.bs.modal', function(e) {
    changePrice()
  });

  $("select").change(function() {
    changePrice()
  });

  $('#payment-form').submit(function () {
      event.preventDefault();
      stripe.confirmCardPayment($('input#client_secret').val(), { 
        payment_method: {
        card: card,
        billing_details: {
         name: $('input#cardholder-name').val(),
         address: $('input#cardholder-address').val()         
      }}
    }).then(function(result) {
    if (result.error) {
       var displayError = document.getElementById('card-errors');
       displayError.textContent = result.error.message;
    } else {
      // The payment has been processed!
      if (result.paymentIntent.status === 'succeeded') {
        // Show a success message to your customer
        // There's a risk of the customer closing the window before callback
        // execution. Set up a webhook or plugin to listen for the
        // payment_intent.succeeded event that handles any business critical
        // post-payment actions.
      }
    }
  });
 });                               
});

