window.addEventListener('DOMContentLoaded', function(){

  //id名が"payment_card_submit-button"というボタンが押されたら取得
  let submit = document.getElementById("payment_card_submit-button");
  
  Payjp.setPublicKey('pk_test_4352092f8deb95210dde9e0e'); //公開鍵

    submit.addEventListener('click', function(e){ //ボタンが押されたらトークン作成

    e.preventDefault(); //ボタンを1度無効化
      // console.log(222)
    let card = { //入力されたカード情報を取得
        number: document.getElementById("payment_card_no").value,
        cvc: document.getElementById("payment_card_cvc").value,
        exp_month: document.getElementById("payment_card_month").value,
        exp_year: document.getElementById("payment_card_year").value
    };
    console.log(card)
    Payjp.createToken(card, function(status, response) {  // トークンを生成
      console.log(response)
      if (status === 200) { 
        $(".number").removeAttr("name");
        $(".cvc").removeAttr("name");
        $(".exp_month").removeAttr("name");
        $(".exp_year").removeAttr("name"); 
        $("#charge-form").append(
          $('<input type="hidden" name="payjp_token">').val(response.id)
        ); //取得したトークンを送信できる状態に
        document.inputForm.submit();
        alert("登録が完了しました"); 
      } else {
        alert("カード情報が正しくありません。"); 
      }
    });
  });
});