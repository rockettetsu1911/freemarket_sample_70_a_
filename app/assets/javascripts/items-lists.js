$(document).on('turbolinks:load', function() {
  console.log(location.pathname);
  if (location.pathname.match(/\/users\/[0-9]+\/sell_list/) != null) {
    $('.buy-list__link').css('background-color', '#eeeeee');
  } else if (location.pathname.match(/\/users\/[0-9]+\/buy_list/) != null) {
    $('.sell-list__link').css('background-color', '#eeeeee');
  }
});