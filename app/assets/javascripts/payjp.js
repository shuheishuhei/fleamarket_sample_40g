$(function() {
  if (!$('#regist_card')[0]) return false;
  
  Payjp.setPublicKey("pk_test_4352092f8deb95210dde9e0e");

  $("#regist_card").on("click", function(e) {
    e.preventDefault();
    //入力されたカード情報の値を取得し、変数cardに格納
    var card = {
        number: $("#card_number_form").val(),
        exp_month: $("#exp_month_form").val(),
        exp_year: $("#exp_year_form").val(),
        cvc: $("#cvc_form").val()
    };
    //それらの値をトークンを生成するメソッドで発行し、pay.jp側に送る
    //以下のcardはpay.jpに送るクレジット情報 respond.idがトークンとして送られてくる
    Payjp.createToken(card, function(status, response) {
      if (status === 200) {
        $("#card_number_form").removeAttr("name");
        $("#exp_month_form").removeAttr("name");
        $("#exp_year_form").removeAttr("name");
        $("#cvc_form").removeAttr("name");
        //取得したトークンを変数tokenに格納し、submit()メソッドを使ってコントローラーに送信
        var token = response.id;
        $("#card_token").append(`<input type="hidden" name="card_token" value=${token}>`)
        $("#card_form").get(0).submit();
      } else {
        alert("カード情報が正しくありません。");
        $("#regist_card").prop('disabled', false);
      }
    });
  });
});