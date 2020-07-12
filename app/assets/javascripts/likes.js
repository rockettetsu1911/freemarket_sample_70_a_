document.addEventListener("turbolinks:load", function() {
  $(function(){
    function likesShowBuildHTML(data){
      var html =`
      <i class="fa fa-star"></i>
      お気に入り ${data.likes_count}
      `
      $('.likes__btn').html(html);
      $('.likes__btn').data('likecheck', `${data.like_id}`);
    }

    $('.likes__btn').on('click',function(){
      if ($('.likes__btn').data('likecheck') == 0) {
        var itemId = $('.likes__btn').data('itemid');
        var userId = $('.likes__btn').data('userid');
        var url = `/items/${itemId}/users/${userId}/likes`
        var type = 'POST'  
      } else if ($('.likes__btn').data('likecheck') > 0) {
        var itemId = $('.likes__btn').data('itemid');
        var userId = $('.likes__btn').data('userid');
        var likeId = $('.likes__btn').data('likecheck')
        var url = `/items/${itemId}/users/${userId}/likes/${likeId}`
        var type = 'DELETE'
      } else {
        return
      }
      $.ajax({
        url: url,
        type: type,
        dataType: 'json',
        processData: false,
        contentType: false
      })
      .done(function(data){
        likesShowBuildHTML(data);
      })
      .fail(function(){
        alert('お気に入りの登録または削除に失敗しました');
      })
    });
  });
});