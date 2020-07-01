$(document).on('turbolinks:load', function() {
  if(document.URL.match(/items\/[\d]+$/)) {
    let $tag_text = $((document.getElementById('js_tag')));
    let tag_html = $tag_text.context.innerHTML;
    var tags = [];

    hashtags = $tag_text.text().match(/[#＃](?<!#＃)[\u30e0-\u9fcf\w０-９ぁ-ヶｦ-ﾟー]+/g);
    $.each(hashtags, function(i, hashtag) {
      tags.push(hashtag.slice(1));
    })

    $.each(tags, function(i, tag) {
      tag_html = tag_html.replace(hashtags[i], `<a href='/tags/${tag}'>${tag}</a>`);
    })

    $tag_text.html(tag_html);
  }
});
