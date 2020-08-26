$(document).on("turbolinks:load", ()=> {
  const buildImg = (index, url)=> {
    const html = `<div class="image__post__area" data-index="${index}">
                    <img data-index="${index}" src="${url}" width="100%" height="80%">
                    <div class="js-remove">削除</div>
                  </div>`;
    return html;
  }

  const buildFileField = (num)=> {
    const html = `<div data-index="${num}" class="js-file_group">
                    <input class="js-file" type="file"
                    name="item[item_images_attributes][${num}][image]"
                    id="item_images_attributes_${num}_image">
                  </div>`;
    return html;
  }

  // function changeLabelFor(num) {
  //   $(".image__block__area__label").attr("for", `item_images_attributes_${num}_image`)
  // }

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
      fileIndex.shift();
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1)
        
        // ５枚以上投稿しようとしたら投稿範囲がなくなる
        // if ($(".image__post__area").length >= 5){  
        //   $(".image__block__area").hide();
        // }
        
      
      // let num = $(`.js-file_group`).last().data("index")
      // changeLabelFor(num)
      
    }
    
  });


  $("#image-box").on("click", ".js-remove", function() {
    $(this).parent().remove();
    const targetIndex = $(this).parent().data("index");
    const hiddenCheck = $(`#item_item_images_attributes_${targetIndex}__destroy`)[0];
    if (hiddenCheck) hiddenCheck.prop("checked", true));
    if ($(".js-file").length == 0) $("#image-box").append(buildFileField(fileIndex[0]));
    $(`img[data-index = ${targetIndex}]`).remove();
   
    // $(`#item_images_attributes_${targetIndex}_image`).remove();
    

    // if ($(".image__post__area").length < 5){  
    //   $(".image__block__area").show();
    // }

    
  });

  if ($(".image__post__area").length >= 5){  
    $(".image__block__area").hide();
  }
  if ($(".image__post__area").length < 5){  
    $(".image__block__area").show();
  }
});
