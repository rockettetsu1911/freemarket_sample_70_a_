$(document).on('turbolinks:load', function() {
  function appendOption(category) {
    var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }

  function appendChildrenBox(insertHtml) {
    var html = '';
    html = `<div class='sellFillOut__selectWrapper__box category-children' id= 'children_wrapper'>
              <select class='select-form' id='category_child' name='item[category]'>
                <option value=0 data-category=0> --- </option>
                ${insertHtml}
              <select>
              <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="angle-down" class="select-arrow" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512"><path fill="" d="M143 352.3L7 216.3c-9.4-9.4-9.4-24.6 0-33.9l22.6-22.6c9.4-9.4 24.6-9.4 33.9 0l96.4 96.4 96.4-96.4c9.4-9.4 24.6-9.4 33.9 0l22.6 22.6c9.4 9.4 9.4 24.6 0 33.9l-136 136c-9.2 9.4-24.4 9.4-33.8 0z"></path></svg>
            </div>`;
    $('.category-wrapper').append(html);
  }

  function appendGrandchildrenBox(insertHtml) {
    var html = '';
    html = `<div class='sellFillOut__selectWrapper__box category-grandchildren' id= 'grandchildren_wrapper'>
              <select class='select-form' id='category_grandchildren' name='item[category]'>
                <option value=0 data-category=0> --- </option>
                ${insertHtml}
              <select>
              <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="angle-down" class="select-arrow" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512"><path fill="" d="M143 352.3L7 216.3c-9.4-9.4-9.4-24.6 0-33.9l22.6-22.6c9.4-9.4 24.6-9.4 33.9 0l96.4 96.4 96.4-96.4c9.4-9.4 24.6-9.4 33.9 0l22.6 22.6c9.4 9.4 9.4 24.6 0 33.9l-136 136c-9.2 9.4-24.4 9.4-33.8 0z"></path></svg>
            </div>`;
    $('.category-wrapper').append(html);
  }

  $('#category_parent').on('change', function() {
    var parentId = document.getElementById('category_parent').value;
    if ((parentId != 0)) { 
      $.ajax({
        url: '/items/get_category_children',
        type: 'GET',
        data: { parent_id: parentId },
        dataType: 'json'
      })
      .done(function(children) {
        $('#children_wrapper').remove();
        $('#grandchildren_wrapper').remove();
        document.getElementById('category_parent').removeAttribute('name');
        var addOptions = '';
        children.forEach(function(child){
          addOptions += appendOption(child);
        });
        appendChildrenBox(addOptions);
      })
      .fail(function() {
        alert('カテゴリー取得に失敗しました');
      })
    }else {
      $('#children_wrapper').remove();
      $('#grandchildren_wrapper').remove();
      var isAttr = document.getElementById('category_parent').hasAttribute('name');
      if (!isAttr) {
        document.getElementById('category_parent').setAttribute('name', 'item[category]');
      }
    }
  });

  $('.category-wrapper').on('change', '#category_child', function() {
    var childId = document.getElementById('category_child').value;
    if (childId != 0) {
      $.ajax({
        url: '/items/get_category_grandchildren',
        type: 'GET',
        data: { child_id: childId },
        dataType: 'json'
      })
      .done(function(grandchildren) {
        if (grandchildren.length != 0) {
          $('#grandchildren_wrapper').remove();
          document.getElementById('category_child').removeAttribute('name');
          var addOptions = '';
          grandchildren.forEach(function(grandchild) {
            addOptions += appendOption(grandchild);
          });
          appendGrandchildrenBox(addOptions);
        }
      })
      .fail(function() {
        alert('カテゴリー取得に失敗しました');
      })
    }else {
      $('#grandchildren_wrapper').remove();
    }
  });
});