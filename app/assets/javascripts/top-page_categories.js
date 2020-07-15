$(document).on('turbolinks:load', function() {
  $(function() {
    $('.category__btn').click(function(){
      $('.category__modal').fadeIn();
      return false;
    });
    $('.category__modal--contents--header--back').click(function(){
      $('.category__modal').fadeOut();
      return false;
    });
  });
});