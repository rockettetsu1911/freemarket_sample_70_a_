$(document).on('turbolinks:load', function() {

  function user_comment_delete(index){
    var html = 
    `
    <div class="user__comment__body--text">
      このコメントは出品者によって削除されました。
    </div>
    `
  return html;
  };

  function current_user_comment_delete(index){
    var html = 
    `
    <div class="user__comment__body__current-user--text">
      このコメントは出品者によって削除されました。
    </div>
    `
  return html;
  };

  // 自分のコメントを削除した場合
  $(".comment__container__list").on('click',"#current_user_comment-delete",function(e){
    var index = $(this).data("index");
    var nickname = $(`.user__comment[data-index=${index}]`).find(".user__comment__current__name");
    nickname.empty();
    var content =  $(`.user__comment[data-index=${index}]`).find(".user__comment__body__current-user");
    content.empty();
    content.append(current_user_comment_delete(index));
  });

  // 他人のコメントを削除した場合
  $(".comment__container__list").on('click',"#user_comment-delete",function(e){
    var index = $(this).data("index");
    var nickname = $(`.user__comment[data-index=${index}]`).find(".user__comment__name");
    nickname.empty();
    var content =  $(`.user__comment[data-index=${index}]`).find(".user__comment__body");
    content.empty();
    content.append(user_comment_delete(index));
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
      })
  .always(function() {
    $('.submit__btn').removeAttr('disabled');
          })
    });

  // 新規コメント表示用
  function new_comment(comment_data){

    var HTML_user_data = 
      `
      <li class="comment--block">
        <section class="user__comment" data-index=${comment_data.id}>
          <div class="user__comment__current__name">
            ${comment_data.user_nickname}
          </div>
          <div class="user__comment__body__current-user">
            <div class="user__comment__body__current-user--text">
              ${comment_data.text}
            </div>
            <div class="user__comment__body__current-user__icon">
              <i class='icon fa-balloon'></i>
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
              <div class="right--icon" id="current_user_comment-delete" data-index=${comment_data.id}>
                <a rel="nofollow" data-method="PATCH" href="/comments/${comment_data.id}">
                  <i class="fa fa-trash"></i>  
                </a>
              </div>
        `

    var HTML_endDiv =
      `
            </div>
          </div>
        </section>
      `
    var HTML_comment_block =
    `
      <section class="user__inforamtion">
        <a class="seller__link" href="#">
          <div class="user__icon">
            <img height="40" width="40" src="/assets/member_photo_noimage_thumb-3f5db95de8bc1582908f994329d16ed91cf4398c2e3e0cc7387e0f2f8f0c88a9.png">
          </div>
    
    `

  var HTML_sellerMark =
    `
          <div class="user__current-name">
          出品者
          </div>
        </a>
      </section>
    </li>
    `

  var HTML_not_sellerMark = 
    `
        </a>
      </section>
    </li>
    `
    if (comment_data.current_user.id== comment_data.seller_id){
        // 出品者とコメントしたユーザーが等しい場合
      var html = HTML_user_data + HTML_deleteBtn +  HTML_endDiv + HTML_comment_block + HTML_sellerMark
    }else{
      // 出品者とコメントしたユーザーが異なる場合
      var html = HTML_user_data  +  HTML_endDiv + HTML_comment_block + HTML_not_sellerMark
          };
    console.log(html);
    return html;
  };
});



