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
    const html = `<img data-index="${index}" src="${url}" width="20%" height="100%">`;
    //width 20% height 100% 親要素（previews） height 162px
    return html;
  }

  let fileIndex = [1,2,3,4,5,6,7,8,9,10];

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
      
      // label for属性をinputタグのid属性に変更する記述が必要
      // $("#image-box").attr('item_images_image', `item[item_images_attributes_${num}_image]`);
      // $("#previews").attr({id: `item_images_image`, for: `item_images_attributes_${num}_image`});

      let num = $(`.js-file_group`).last().data("index")
      changeLabelFor(num)
      fileIndex.shift();
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1)

      if ( targetIndex == 5 ) {
        $('.js-file').hide();
      }
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



// $(document).on('turbolinks:load', function(){
//   $(function(){

//     function buildHTML(count) {
//       var html = `<div class="preview-box" id="preview-box__${count}">
//                     <div class="upper-box">
//                       <img src="" alt="preview">
//                     </div>
//                     <div class="lower-box">
//                       <div class="delete-box" id="delete_btn_${count}">
//                         <span>削除</span>
//                       </div>
//                     </div>
//                   </div>`
//       return html;
//     }

//     // ラベルのwidth
//     function setLabel() {
//       var prevContent = $('.label-content').prev();
//       labelWidth = (620 - $(prevContent).css('width').replace(/[^0-9]/g, ''));
//       $('.label-content').css('width', labelWidth);
//     }
//     // プレビュー追加
//     $(document).on('change', '.hidden-field', function() {
//       setLabel();

//       var id = $(this).attr('id').replace(/[^0-9]/g, '');

//       $('.label-box').attr({id: `label-box--${id}`,for: `item_images_attributes_${id}_image`});
//       var file = this.files[0];
//       var reader = new FileReader();
//       reader.readAsDataURL(file);
//       reader.onload = function() {
//         var image = this.result;

//         if ($(`#preview-box__${id}`).length == 0) {
//           var count = $('.preview-box').length;
//           var html = buildHTML(id);
//           var prevContent = $('.label-content').prev();
//           $(prevContent).append(html);
//         }
//         // イメージ追加
//         $(`#preview-box__${id} img`).attr('src', `${image}`);
//         var count = $('.preview-box').length;

//         if (count == 5) { 
//           $('.label-content').hide();
//         }

//         // ラベルのwidth
//         setLabel();

//         if(count < 5){
//           $('.label-box').attr({id: `label-box--${count}`,for: `item_images_attributes_${count}_image`});
//         }
//       }
//     });

//     // 画像削除
//     $(document).on('click', '.delete-box', function() {
//       var count = $('.preview-box').length;
//       setLabel(count);
//       var id = $(this).attr('id').replace(/[^0-9]/g, '');
   
//       $(`#preview-box__${id}`).remove();
      
//       $(`#item_images_attributes_${id}_image`).val("");

//       //削除時のラベル
//       var count = $('.preview-box').length;

//       if (count == 4) {
//         $('.label-content').show();
//       }
//       setLabel(count);

//       if(id < 5){
//         $('.label-content').attr({id: `label-box--${id}`,for: `item_images_attributes_${id}_image`});
//       }
//     });
//   });
// })