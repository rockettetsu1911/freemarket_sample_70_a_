$(document).on('turbolinks:load', function() {
  $(".comment__container__list").on('click','.right--icon',function(e){
    e.preventDefault();
    var index = $(this).data("index");
    $(`.comment--block[data-index=${index}]`).remove();
    });

    function user__comment__delete(index){
      var html = 
      `
      <div class="user__comment__body--text">
        コメントは出品者により削除されました。
      </div>
      `
    return html;
    };

    function current__user__comment__delete(index){
      var html = 
      `
      <div class="user__comment__body__current-user--text">
        コメントは出品者により削除されました。
      </div>
      `
    return html;
    };

  // 自分のコメントを削除した場合
  $(".comment__container__list").on('click',"#current_user_comment-delete",function(e){
    e.preventDefault();
    var index = $(this).data("index");
    var content =  $(`.user__comment[data-index=${index}]`).find(".user__comment__body__current-user");
    content.empty();
    content.append(current__user__comment__delete(index));
  });

  // 他人のコメントを削除した場合
  $(".comment__container__list").on('click',"#user_comment-delete",function(e){
    e.preventDefault();
    var index = $(this).data("index");
    var content =  $(`.user__comment[data-index=${index}]`).find(".user__comment__body");
    content.empty();
    content.append(user__comment__delete(index));
  });

    // コメント作成した場合
  $('.new__comment').on('submit', function(e){
    e.preventDefault();
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
    var html = new_comment(comment_data);
    $('.comment__container__list').append(html)
    $('.form__area').val("");
    $('.comment__container__list').animate({ scrollTop: $('.comment__container__list')[0].scrollHeight});
  })
  .fail(function() {
    alert("メッセージ送信に失敗しました");
      });
    });

  // 新規コメント表示用
  function new_comment(comment_data){

    var HTML_comment_block
      `
      <li class="comment--block">
        <section class="user__inforamtion">
          <a class="seller__link" href="#">
          <div class="user__icon">
          　<img src="member_photo_noimage_thumb.png">
          </div>
      `

    var HTML_sellerMark =
        `
          <div class="user__name">
          出品者
          </div>
        </a>
        `

    var HTML_not_sellerMark = 
        `
          <div class="user__name">
          </div>
        </a>
        `

    var HTML_user_data = 
      `
        <section class="user__comment" data-index=${comment_data.id}>
          <div class="user__comment__current__name">
            ${comment_data.user_nickname}
          </div>
          <div class="user__comment__body__current-user">
            <div class="user__comment__body__current-user--text">
              ${comment_data.text}
            </div>
            <div class="user__comment__body__current-user__icon">
              <i class='fa fa-balloon'></i>
            </div>
            <div class="user__comment__body__current-user__date">
              <div class="left--icon">
                <div class="icon--watch">
                  <i class='fa fa-clock'></i>
                </div>
                <span class> 
                  ${comment_data.created_at}
                </span>
              </div>
            
      `
    var HTML_deleteBtn =  
        `
              <div class="right--icon #current_user_comment-delete" data-index=${comment_data.id}>
                <a rel="nofollow" data-method="delete" href="/comments/${comment_data.id}">
                  <i class="fa fa-trash"></i>  
                </a>
              </div>
        `

    var HTML_endDiv =
      `
              </div>
            </div>
          </section>
        </section>
      </li> 
      `
    if (comment_data.item_id == comment_data.user_id){
        // 出品者とコメントしたユーザーが等しい場合
      var html = HTML_comment_block + HTML_sellerMark + HTML_user_data + HTML_deleteBtn + HTML_endDiv
    }else{
      // 出品者とコメントしたユーザーが異なる場合
      var html = HTML_comment_block + HTML_not_sellerMark + HTML_user_data +  HTML_endDiv
      console.log(html);
          };

    return html;
  };
});



