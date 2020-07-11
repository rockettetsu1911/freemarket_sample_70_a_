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

  $('#sell-form').on('submit',function() {
    function scrollToPicture() {
      scrollTo(0, position);
    }
    var element = document.getElementById('picture-scroll');
    var rect = element.getBoundingClientRect();
    var position = window.pageYOffset + rect.top;
    $is_upload = $('#item_pictures_attributes_0_image');
    $is_exist = $('.picture-preview__wrapper');
    if((!$is_upload.val()) && $is_exist.length == 0) {
      document.getElementById('sell-picture-alert').textContent = '画像がありません';
      scrollToPicture();
      return false;
    }
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
    messages: {
      'item[name]': {
        required: '入力してください',
      },
      'item[explanation]': {
        required: '入力してください',
      },
      'item[category]': {
        required: '選択してください'
      },
      'item[condition]': {
        required: '選択してください'
      },
      'postage': {
        required: '選択してください'
      },
      'prefecture': {
        required: '選択してください'
      },
      'delivery-date': {
        required: '選択してください'
      },
      'item[price]': {
        required: '入力してください',
        min: '300以上9999999以下で入力してください',
        max: '300以上9999999以下で入力してください'
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
