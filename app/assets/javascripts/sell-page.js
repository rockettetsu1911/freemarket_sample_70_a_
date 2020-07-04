$(document).on('turbolinks:load', function() {
  $('#sell-price').on('input', function() {
    let price = $('#sell-price').val();
    if(price >= 300 && price <= 9999999) {
      $('#fee').text('¥' + localStr(Math.ceil(price * 0.03)));
      $('#profit').text('¥' + localStr(Math.floor(price * 0.97)));
      $('#sell-price-alert').text('');
    } else {
      $('#fee').text('-');
      $('#profit').text('-');
    }
  });
  $('#sell-explanation').on('input', function() {
    let count = $(this).val().length;
    $('#sell-word-count').text(count);
  });
  
  $('#sell-form').validate( {
    rules: {
      'item[name]': {
        required: true,
        maxlength: 40
      },
      'item[explanation]': {
        required: true,
        maxlength: 1000
      },
      'item[category]': {
        required: true
      },
      'item[condition]': {
        required: true
      },
      'postage': {
        required: true
      },
      'prefecture': {
        required: true
      },
      'delivery-date': {
        required: true
      },
      'item[price]': {
        required: true,
        number: true,
        min: 300,
        max: 9999999
      },
    },
    errorPlacement: function(error, element) {
      if(element.attr('name')=='item[price]') {
        error.insertAfter('#sell-price-alert');
      }
      else {
        error.insertAfter(element);
      }
    }
    
  });
});

function localStr(str) {
  var num = Number(str);
  str = num.toLocaleString('jp');
  return(str);
}
