$(document).on('turbolinks:load', function() {
  $(document).on('click', '.picture-upload', function() {
    var preview = $('<div class="picture-preview__wrapper"><img class="preview"></div><div class="preview-btn"><div class="preview-btn--delete">削除</div></div>'); 
    var append_input = $(`<li class="pictureInput"><label class="pictureInput__uploadLabel"><div class="pictureInput__uploadLabel__box">クリックしてファイルをアップロード<div class="pictureInput__uploadLabel__box--input"><input class="picture-upload hidden" type="file"></div></div></label></li>`);
    $ul = $('#picturePreviews');
    $li = $(this).parents('li');
    $label = $(this).parents('.pictureInput__uploadLabel');
    $inputs = $ul.find('.picture-upload');
    $('.picture-upload').on('change', function(e) {
      var reader = new FileReader();
      reader.readAsDataURL(e.target.files[0]);
      reader.onload = function(e) {
        $(preview).find('.preview').attr('src', e.target.result);
      };

      $li.append(preview);
      $label.css('display', 'none');
      $li.removeClass('pictureInput');
      $li.addClass('picture-preview');
      $list = $ul.find('.picture-preview');

      $('#picturePreviews li').css({
        'width': `120px`
      });

      var listCnt = $list.length;
      if(listCnt <= 4) {
        $ul.append(append_input);
        $('#picturePreviews li:last-child').css({
          'width': `calc(100% - (20% * ${listCnt}))`
        });
      }
      else if(listCnt == 5) {
        $li.addClass('picture-preview');
        $ul.append(append_input);
        $('#picturePreviews li:last-child').css({
          'width': '100%'
        });
      }
      else if(listCnt <= 9) {
        $li.addClass('picture-preview');
        $ul.append(append_input);
        $('#picturePreviews li:last-child').css({
          'width': `calc(100% - (20% * (${listCnt} - 5 )))`
        });
      }

      $inputs.each(function(num, input) {
        $(input).removeAttr('name');
        $(input).attr({
          name: 'item[pictures_attributes][' + num + '][image]',
          id:'item_pictures_attributes_' + num + '_image'
        });
      });
    });
  });

  $(document).on('click', '.preview-btn--delete', function() {
    var append_input = $(`<li class="pictureInput"><label class="pictureInput__uploadLabel"><div class="pictureInput__uploadLabel__box">クリックしてファイルをアップロード<div class="pictureInput__uploadLabel__box--input"><input class="picture-upload hidden" type="file"></div></div></label></li>`);
    $li = $(this).parents('.picture-preview');
    
    $li.remove();
    $ul = $('#picturePreviews');
    $list = $ul.find('.picture-preview');

    var listCnt = $list.length;
    if(listCnt <= 4) {
      $('#picturePreviews li:last-child').css({
        'width': `calc(100% - (20% * ${listCnt}))`
      });
    }
    else if(listCnt == 5) {
      $('#picturePreviews li:last-child').css({
        'width': '100%'
      });
    }
    else if(listCnt < 9) {
      $('#picturePreviews li:last-child').css({
        'width': `calc(100% - (20% * (${listCnt} - 5 )))`
      });
    }
    else if(listCnt == 9) {
      $ul.append(append_input);
      $('#picturePreviews li:last-child').css({
        'width': `calc(100% - (20% * (${listCnt} - 5 )))`
      });
    }
  });
});

