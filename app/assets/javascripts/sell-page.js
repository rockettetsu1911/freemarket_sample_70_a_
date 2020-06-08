$(function() {
  $('#sell-price').on('input', function() {
    let price = $('#sell-price').val();
    if(price >= 300 && price <= 9999999) {
      $('#fee').text('¥' + localStr(Math.ceil(price * 0.03)));
      $('#profit').text('¥' + localStr(Math.floor(price * 0.97)));
      $('#sell-price-alert').text('');
    } else {
      $('#fee').text('-');
      $('#profit').text('-');
      $('#sell-price-alert').text('300以上9999999以下で入力してください');
    }
  });
  $('#sell-name').on('input', function() {
    let count = $(this).val().length;
    if(count > 40) {
      $('#sell-name-alert').text('40文字以下で入力してください');
    } else {
      $('#sell-name-alert').text('');
    }
  });
  $('#sell-explanation').on('input', function() {
    let count = $(this).val().length;
    $('#sell-word-count').text(count);
    if(count > 1000) {
      $('#sell-word-count').css('color', 'red');
      $('#sell-word-count-alert').text('1000文字以下で入力してください');
    } else {
      $('#sell-word-count').css('color', '');
      $('#sell-word-count-alert').text('');
    }
  });
});

function localStr(str) {
  var num = Number(str);
  str = num.toLocaleString('jp');
  return(str);
}

$(document).on('turbolinks:load', ()=> {
  const buildFileField = (num)=> {
    const html = `<div data-index="${num}" class="sellFillOut__uploadBox">
                    <label class='sellFillOut__uploadBox__itemPhotos'>
                      <input class="uploadBox-file" type="file"
                      name="item[pictures_attributes][${num}][src]"
                      id="item_pictures_attributes_${num}_src"><br>
                      <i class='fas fa-camera uploadBox-icon'></i>
                      <p>ドラッグアンドドロップ<br>またはクリックしてファイルをアップロード</p>
                    </label>
                    <div class="uploadBox-remove">削除</div>
                  </div>`;
    return html;
  }

  const buildImg = (index, url)=> {
    const html = `<img data-index="${index}" image="${url}" width="100px" height="100px">`;
    return html;
  }

  let fileIndex = [1,2,3,4,5,6,7,8,9,10];
  // 既に使われているindexを除外
  // lastIndex = $('.sellFillOut__uploadBox:last').data('index');
  // fileIndex.splice(0, lastIndex);
  // $('.hidden-destroy').hide();
  $('#image-box').on('change', '.uploadBox-file', function(e) {
    console.log($(this));
    const targetIndex = $(this).parent('.sellFillOut__uploadBox').attr('data-index');
    console.log(targetIndex);
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);
    if(img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('image', blobUrl);
    } else {
      $('#previews').append(buildImg(targetIndex, blobUrl));
      $('#image-box').append(buildFileField(fileIndex[0]));
      fileIndex.shift();
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1)
    }
  });

  $('#image-box').on('click', '.uploadBox-remove', function() {
    // const targetIndex = $(this).parent().data('index')
    // // 該当indexを振られているチェックボックスを取得する
    // const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    // // もしチェックボックスが存在すればチェックを入れる
    // if (hiddenCheck) hiddenCheck.prop('checked', true);
    $(this).parent().remove();
    $(`img[data-index="${targetIndex}"]`).remove();
    if ($('.uploadBox-file').length == 0) $('#image-box').append(buildFileField(fileIndex[0]));
  });
});