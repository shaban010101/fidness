//= require jquery/dist/jquery.min.js


$(document).ready(function() {
  var elements = stripe.elements();
  var card = elements.create('card');
  var clientSecret = null;
  var spinnerTarget = document.getElementById('myModal');
  var spinnerOptions = {
    lines: 13, // The number of lines to draw
    length: 38, // The length of each line
    width: 17, // The line thickness
    radius: 45, // The radius of the inner circle
    scale: 1, // Scales overall size of the spinner
    corners: 1, // Corner roundness (0..1)
    color: '#ffffff', // CSS color or array of colors
    fadeColor: 'transparent', // CSS color or array of colors
    speed: 1, // Rounds per second
    rotate: 0, // The rotation offset
    animation: 'spinner-line-fade-quick', // The CSS animation name for the lines
    direction: 1, // 1: clockwise, -1: counterclockwise
    zIndex: 2e9, // The z-index (defaults to 2000000000)
    className: 'spinner', // The CSS class to assign to the spinner
    top: '50%', // Top position relative to parent
    left: '50%', // Left position relative to parent
    shadow: '0 0 1px transparent', // Box-shadow for the lines
    position: 'absolute' // Element positioning
  };

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
    var monthYear = document.getElementsByClassName('react-datepicker__current-month')[0].textContent;
    var day = document.getElementsByClassName('react-datepicker__day--selected')[0].textContent;
    var time = document.getElementsByClassName("react-datepicker__time-list-item--selected")[0].textContent;
    var parsedDate = Date.parse(day + monthYear);
    var date = new Date(parsedDate);
    var timeParts = time.split(':');
    var unixTime = date.setHours(timeParts[0], timeParts[1]);
    var sessionAt = new Date(unixTime).toISOString();
    var authenticityToken = $("meta[name='csrf-token']").attr("content");

    var clientSecret = $.post('/payment-intent', 
                         { 
                           trainer_id: trainerId, 
                           option_id: $('#option').find(':selected')[0].value,
                           session_at: sessionAt,
                           authenticity_token: authenticityToken}).then(function(response) {
                             
        $("<input />").attr("type", "hidden")
          .attr("name", "client_secret")
          .attr("value", response.client_secret)
          .attr("id", 'client_secret')                   
          .appendTo("#payment-form");                     
    });
    
    $('.total-price').append("Total price: " + price + " / " + sessionPrice + " per session");
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
       window.location = '/future-sessions/';        
    };
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
  
  var purchaseButton = document.getElementById('purchase-button');
  purchaseButton.addEventListener('click',  checkTimeSelected);

  function checkTimeSelected(event) {
    event.preventDefault;
    
    var time = document.getElementsByClassName("react-datepicker__time-list-item--selected")[0];
    if(time != undefined) {
      $('#myModal').modal('show');
    } else { 
      $('#error-message').css('display', 'block');
    };
  };
});

