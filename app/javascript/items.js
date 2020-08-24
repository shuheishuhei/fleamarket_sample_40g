$(document).on("turbolinks:load", ()=> {
  const buildFileField = (num)=> {
    const html = `<div data-index="${num}" class="js-file_group">
                    <input class="js-file" type="file"
                    name="item[item_images_attributes][${num}][image]"
                    id="item_images_attributes_${num}_image">
                  </div>`;
    return html;
  }

  function changeLabelFor(num) {
    $(".image__block__area__label").attr("for", `item_images_attributes_${num}_image`)
  }

  const buildImg = (index, url)=> {
    const html = `<div class="image__post__area" data-index="${index}">
                    <img data-index="${index}" src="${url}" width="124px" height="135px">
                    <div class="edit__image__box" data-index="${index}">
                      <div class="js-edit">編集</div>
                      <div class="js-remove">削除</div>
                    </div>
                  </div>`;
  
    return html;
  }


  

  let fileIndex = [1,2,3,4,5];

  lastIndex = $(".js-file_group:last").data("index");
  fileIndex.splice(0, lastIndex);

  $(".hidden-destroy").hide();

  $("#image-box").on("change", ".js-file", function(e) {
    const targetIndex = $(this).parent().data("index");
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);
    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute("src", blobUrl);
    } else {
      $("#previews").append(buildImg(targetIndex, blobUrl));

      $("#image-box").append(buildFileField(fileIndex[0]));  
        
        // ５枚以上投稿しようとしたら投稿範囲がなくなる
        if ($(".image__post__area").length >= 5){  
          $(".image__block__area").hide();
        }
        
      
      let num = $(`.js-file_group`).last().data("index")
      changeLabelFor(num)
      fileIndex.shift();
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1)
    }
    
  });



// 編集機能
  $("#image-box").on("click", ".js-edit", function() {
    const targetIndex = $(this).parent().data("index");
    console.log(targetIndex)
    // クラス名js-fileかつ該当のdata-indexをもつinputをクリックする
    $(`.js-file[data-index="${targetIndex}"]`).click();
    // $('クラス名がjs-fileかつdata-indexがtargetIndexと同じinput{type=file}').クリックメソッド
  });



  $("#image-box").on("click", ".js-remove", function() {
    const targetIndex = $(this).parent().data("index");
    const hiddenCheck = $(`#item_item_images_attributes_${targetIndex}__destroy`)[0];
    if ($(hiddenCheck).prop("checked", true));

    $(this).parent().parent().remove();
    $(`#item_images_attributes_${targetIndex}_image`).remove();
    $(`img[data-index="${targetIndex}"]`).remove();

    if ($(".image__post__area").length < 5){  
      $(".image__block__area").show();
    }

    if ($(".js-file").length == 0) $("#image-box").append(buildFileField(fileIndex[0]));

  });

  if ($(".image__post__area").length >= 5){  
    $(".image__block__area").hide();
  }
  if ($(".image__post__area").length < 5){  
    $(".image__block__area").show();
  }
});
