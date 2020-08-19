$(document).on("turbolinks:load", ()=> {
  const buildFileField = (num)=> {
    const html = `<div data-index="${num}" class="js-file_group">
                    <input class="js-file" type="file"
                    name="item[item_images_attributes][${num}][image]"
                    id="item_images_attributes_${num}_image"><br>
                    <div class="js-remove">削除</div>
                  </div>`;
    return html;
  }

  function changeLabelFor(num) {
    $(".image__block__area__label").attr("for", `item_images_attributes_${num}_image`)
  }

  const buildImg = (index, url)=> {
    const html = `<div class="image__post__area">
                    <img data-index="${index}" src="${url}" width="100%" height="80%">
                    <div class="js-remove">削除</div>
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
        if($(".js-file_group").length > 5){  
          return false;
        }
      
      // label for属性をinputタグのid属性に変更する記述が必要
      let num = $(`.js-file_group`).last().data("index")
      changeLabelFor(num)
      fileIndex.shift();
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1)
    }
    
  });


  $("#image-box").on("click", ".js-remove", function() {
    const targetIndex = $(this).parent().data("index")
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    if (hiddenCheck) hiddenCheck.prop("checked", true);

    $(this).parent().remove();
    $(`img[data-index="${targetIndex}"]`).remove();

    if ($(".js-file").length == 0) $("#image-box").append(buildFileField(fileIndex[0]));
  });
});
