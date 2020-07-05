$(document).on('turbolinks:load', function() {
  jQuery.validator.addMethod("isZenkaku", function(value, element) {
    return this.optional( element ) || /^[^\x20-\x7e]*$/.test( value );
  }, '全角で入力してください');
  
  jQuery.validator.addMethod("isZenkakuKana", function(value, element) {
    return this.optional( element ) || /^[ァ-ンヴー]*$/.test( value );
  }, '全角カナで入力してください');
    
  jQuery.validator.addMethod("isBirthday", function(value, element) {
    return this.optional( element ) || /^\d{4}\/\d{1,2}\/\d{1,2}$/.test( value );
  }, '正しい年月日を入力してください');

  jQuery.validator.addMethod("isTelephone", function(value, element) {
    return this.optional( element ) || /\d+/.test( value );
  }, '数字で入力してください');

  jQuery.validator.addMethod("isZipCode", function(value, element) {
    return this.optional( element ) || /^\d{7}$/.test( value );
  }, '正しい郵便番号を入力してください');
 
  $.validator.addMethod("isPrefecture", function(value, element) {
    return this.optional( element ) || /^[a-z]+$/.test( value );
    }, "都道府県を選択してください");

  $("#signup_form").validate({
    rules: {
      'user[nickname]': {
        required: true,
        maxlength: 20,
      },
      'user[last_name]': {
        required: true,
        maxlength: 15,
        isZenkaku: true
      },
      'user[first_name]': {
        required: true,
        maxlength: 15,
        isZenkaku: true
      },
      'user[last_name_kana]': {
        required: true,
        maxlength: 30,
        isZenkakuKana: true
      },
      'user[first_name_kana]': {
        required: true,
        maxlength: 30,
        isZenkakuKana: true
      },
      'user[email]': {
        required: true,
        email: true
      },
      'user[birthday]': {
        required: true,
        isBirthday: true
      },
      'user[telephone]': {
        required: true,
        maxlength: 11,
        minlength: 10,
        isTelephone: true
      },
      'user[introduction]': {
        required: true,
        maxlength: 300
      },
      'user[password]': {
        required: true,
        minlength: 7
      },
      'user[password_confirmation]': {
        required: true,
        minlength: 7,
        equalTo: '#user_password'
      },
    },
    errorClass: "invalid",
    errorElement: "p",
    validClass: "valid", 
  });
  $("#address_form").validate({
    rules: {
      'address[dest_first_name]': {
        required: true,
        maxlength: 15,
        isZenkaku: true
      },
      'address[dest_last_name]': {
        required: true,
        maxlength: 15,
        isZenkaku: true
      },
      'address[dest_first_name_kana]': {
        required: true,
        maxlength: 30,
        isZenkakuKana: true
      },
      'address[dest_last_name_kana]': {
        required: true,
        maxlength: 30,
        isZenkakuKana: true
      },
      'address[zip_code]': {
        required: true,
        isZipCode: true
      },
      'address[prefecture]': {
        required: true,
        isPrefecture: true
      },
      'address[city]': {
        required: true,
        maxlength: 30,
        isZenkaku: true
      },
      'address[block_number]': {
        required: true,
        maxlength: 30,
        isZenkaku: true
      },
      'address[building]': {
        maxlength: 30,
        isZenkaku: true
      },
      'address[telephone]': {
        maxlength: 11,
        minlength: 10,
        isTelephone: true
      },
    },
    errorClass: "invalid",
    errorElement: "p",
    validClass: "valid", 
  });

});

