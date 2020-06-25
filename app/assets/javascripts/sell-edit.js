$(document).on('turbolinks:load', function() {
  var append_input = $(`<li class="pictureInput"><label class="pictureInput__uploadLabel"><div class="pictureInput__uploadLabel__box"><i class="fas fa-camera uploadBox-icon"></i><p>クリックしてファイルをアップロード</p><div class="pictureInput__uploadLabel__box--input"><input class="picture-upload hidden" type="file"></div></div></label></li>`);
  $ul = $('.picturePreviews');
  $list = $ul.find('.picture-preview');
  $input = $ul.find('.pictureInput');

  var listCnt = $list.length;
  if($input.length == 0) {

    if(listCnt <= 4) {
      $ul.append(append_input);
      $('.picturePreviews li:last-child').css({
        'width': `calc(100% - (20% * ${listCnt}))`
      });
    }
    else if(listCnt == 5) {
      $ul.append(append_input);
      $('.picturePreviews li:last-child').css({
        'width': '100%'
      });
    }
    else if(listCnt <= 9) {
      $ul.append(append_input);
      $('.picturePreviews li:last-child').css({
        'width': `calc(100% - (20% * (${listCnt} - 5 )))`
      });
    }
  }
});