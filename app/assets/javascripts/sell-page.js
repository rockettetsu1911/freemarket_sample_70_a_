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
      $('#sell-price-alert').text('300以上9999999以下で入力してください');
    }
  });
  $('#sell-name').on('input', function() {
    let count = $(this).val().length;
    if(count > 40) {
      $('#sell-name-alert').text('40文字以下で入力してください');
    } else {
      $('#sell-name-alert').text('');
    }
  });
  $('#sell-explanation').on('input', function() {
    let count = $(this).val().length;
    $('#sell-word-count').text(count);
    if(count > 1000) {
      $('#sell-word-count').css('color', 'red');
      $('#sell-word-count-alert').text('1000文字以下で入力してください');
    } else {
      $('#sell-word-count').css('color', '');
      $('#sell-word-count-alert').text('');
    }
  });
  
  $('#sell-form').validate( {
    rules: {
      'item[pictures_attributes]': {
        required: true
      },
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
      'item[price]': {
        required: true,
        number: true,
        min: 300,
        max: 9999999
      },
    },
    errorPlacement: function(error, element) {
      if(element.attr('name')=='item[price]') {
        error.insertAfter('.sellFillOut__label--wrapper:first');
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
