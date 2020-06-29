$(document).on('turbolinks:load', function() {
  $(".comment__container__list").on('click','.right--icon',function(e){
    e.preventDefault()
    var index = $(this).data("index");
    $(`.comment--block[data-index=${index}]`).remove();
    });

    function user__comment__delete(index){
      var html = 
      `
      <div user__comment__body__current-user--text>
        コメントは出品者により削除されました。
      </div>
      `

    return html;
    };

      // ===================================
  // 自分のコメントを削除した場合
  // ===================================
  $(".comment__container__list").on('click',"#current_user_comment-delete",function(e){
    e.preventDefault()
    var index = $(this).data("index");
    var content =  $(`.user__comment[data-index=${index}]`).find(".user__comment__body__current-user");
    content.empty();
    content.append(user__comment__delete(index));
  });
  // ===================================
  // 他人のコメントを削除した場合
  // ===================================
  $(".comment__container__list").on('click',"#user_comment-delete",function(e){
    e.preventDefault()
    var index = $(this).data("index");
    var content =  $(`.user__comment[data-index=${index}]`).find(".user__comment__body");
    content.empty();
    content.append(PLEdelete(index));
  });

  // ===================================
// コメント作成した場合
// ===================================
$('.submit__btn').on('submit', function(e){
  e.preventDefault()
  var formData = new FormData(this);
  var url = $(this).attr('action');
  $.ajax({
    url: url,
    type: "POST",
    data: formData,
    dataType: 'json',
    processData: false,
    contentType: false
  })
.done(function(comment_data){
  console.log(comment_data);
  var html = new_comment(comment_data);
  $(".comment__container__list").append(html)
  $('#comment_body').val("");
  $('.comment_list').animate({ scrollTop: $('.comment_list')[0].scrollHeight});
})
.fail(function() {
  alert("メッセージ送信に失敗しました");
    });
  });
});
