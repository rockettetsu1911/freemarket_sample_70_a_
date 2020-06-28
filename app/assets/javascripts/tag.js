$(document).on('turbolinks:load', function() {
  let $tag_text = $((document.getElementById('js_tag')));
  let tag_link = $tag_text.text();
  var tag_html = tag_link;
  var tags = [];

  $text_parent = $tag_text.parents('.top__contents__items__text');
  hashtags = $tag_text.text().match(/[#＃](?<!#＃)[\w\p{Han}０-９ぁ-ヶｦ-ﾟー]+/g);

  $.each(hashtags, function(i, hashtag) {
    tags.push(hashtag.slice(1));
  })

  $.each(tags, function(i, tag) {
    tag_html = tag_html.replace(hashtags[i], `<a href='/tags/${tag}'>${tag}</a>`);
    console.log(tag_html);
  })

  $tag_text.html(tag_html);
});
