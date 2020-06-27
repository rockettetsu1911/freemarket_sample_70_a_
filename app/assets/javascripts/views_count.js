$(function(){
  function buildHTML(item){
      var html =
      `<i class="fa fa-eye"></i>
      閲覧回数 ${item.view_count}`
      return html;
  }
  var reloadViewCount = function(){
    var itemId = $('.top__contents__items').data('itemid');
    $.ajax({
      url: itemId,
      type: "GET",
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $('#view_count').html(html);
    })
  }
  setInterval(reloadViewCount, 10000);
});