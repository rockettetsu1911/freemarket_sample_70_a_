$(document).on('turbolinks:load', function() {
  jQuery.validator.addMethod("isZenkaku", function(value, element) {
    return this.optional( element ) || /^[^\x20-\x7e]*$/.test( value );
  }, '全角で入力してください');
  
  jQuery.validator.addMethod("isZenkakuKana", function(value, element) {
    return this.optional( element ) || /^[ァ-ンヴー]*$/.test( value );
  }, '全角カナで入力してください');
    
  jQuery.validator.addMethod("isBirthday", function(value, element) {
    return this.optional( element ) || /\A(19|20)\d{2}\/([1-9]|0[1-9]|1[0-2])\/([1-9]|0[1-9]|[12][0-9]|3[01])\z/.test( value );
  }, '正しい年月日で入力してください');

  jQuery.validator.addMethod("isTelephone", function(value, element) {
    return this.optional( element ) || /\d+/.test( value );
  }, '数字で入力してください');

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

});

