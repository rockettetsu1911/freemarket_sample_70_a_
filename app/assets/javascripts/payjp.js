$(document).on('turbolinks:load', function() {
    Payjp.setPublicKey("pk_test_0df3d3eb150a3f3dd0f2fc3e");
    const btn = document.getElementById('token_submit'); //IDがtoken_submitの場合に取得する
    btn.addEventListener("click", (e) => {　//ボタンが押されたときに作動させる
        e.preventDefault();　//ボタンを一旦無効化する

      //カード情報生成
      const card = {
        number: document.getElementById("card_number").value,
        cvc: document.getElementById("cvc").value,
        exp_month: document.getElementById("exp_month").value,
        exp_year: document.getElementById("exp_year").value
      }; //入力されたデータを取得する

      //cardトークン生成
      Payjp.createToken(card, (status, response) => {
        if (status === 200) { 
          $("#card_number").removeAttr("name");
          $("#cvc").removeAttr("name");
          $("#exp_month").removeAttr("name");
          $("#exp_year").removeAttr("name"); //カード情報を自分のサーバにpostせず削除する
          $("#card_token").append(
            $('<input hidden name="payjp-token">').val(response.id)
          ); //トークンを送信できるように隠しタグを生成
          document.inputForm.submit();
          alert("登録が完了しました"); 
        } else {
          alert("カード情報が正しくありません。");
        }
      });
    });
  false;
});