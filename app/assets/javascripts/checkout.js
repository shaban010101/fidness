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

  function changeLoadingState(isLoading) {
    if (isLoading) {
      document.querySelector("button").disabled = true;
      document.querySelector("#spinner").classList.remove("hidden");
      document.querySelector("#card-button").classList.add("hidden");
    } else {
      document.querySelector("button").disabled = false;
      document.querySelector("#spinner").classList.add("hidden");
      document.querySelector("#card-button").classList.remove("hidden");
    }
  };

  $('#payment-form').submit(function () {
      event.preventDefault();
      changeLoadingState(true);
      stripe.confirmCardPayment($('input#client_secret').val(), { 
        payment_method: {
        card: card,
        billing_details: {
         name: $('input#cardholder-name').val(),
         address: $('input#cardholder-address').val()         
      }}
    }).then(function(result) {
    if (result.error) {
      changeLoadingState(false);
      var displayError = document.getElementById('card-errors');
      displayError.textContent = result.error.message;
    } else {
       $.post('/sessions', { user_id: $('input#user_id').val(),
                             trainer_id: $('input#trainer_id').val(), 
                             option_id: $('#option').find(':selected')[0].value}).then(function(response) {
       window.location = '/sessions/' + response.id;                      
    });
   }
  });
 });

  function orderComplete(clientSecret) {
    stripe.retrievePaymentIntent(clientSecret).then(function(result) {
      var paymentIntent = result.paymentIntent;
      var paymentIntentJson = JSON.stringify(paymentIntent, null, 2);

      document.querySelector("#payment-form").classList.add("hidden");
      document.querySelector("pre").textContent = paymentIntentJson.status;

      document.querySelector(".sr-result").classList.remove("hidden");
      
      setTimeout(function() {
        document.querySelector(".sr-result").classList.add("expand");
      }, 200);

      changeLoadingState(false);
   });
  };
});

