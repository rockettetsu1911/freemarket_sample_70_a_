$(function(){
  function itemIndexBuildHTML(items){
    $.each(items, function(index, item){
      var elems = $.find(`[data-itemid = ${item.id}]`);
      $.each(elems, function(index, elem){
        elem.getElementsByClassName('itemDetails__view--count')[0].innerHTML = item.view_count;
      });
    });
  }
  function itemShowBuildHTML(item){
      var html =
      `<i class="fa fa-eye"></i>
      閲覧回数 ${item.view_count}`

      $('#view_count').html(html);
  }
  var reloadViewCount = function(){
    if (location.pathname == "/") {
      var url = "/";
    }else if (location.pathname.match(/\/items\/[0-9]+/) != null ) {
      var url = $('.top__contents__items').data('itemid');
    }
    $.ajax({
      url: url,
      type: "GET",
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      if (location.pathname == "/") {
        itemIndexBuildHTML(data);
      }else if (location.pathname.match(/\/items\/[0-9]+/) != null ) {
        itemShowBuildHTML(data);
      }
    })
  }
  setInterval(reloadViewCount, 7000);
});