//オプションを作成
$(function(){
  function appendOption(category){
    var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  
// 子カテゴリー用のhtmlの作成。子カテゴリーのidはいらないので name=""としています。
  function appendChildrenBox(insertHTML) {
    var childSelectHtml = '';
    childSelectHtml = 
        `<div class='categoryWrapperEdit' id= 'children_wrapper_edit'>
          <div class="categoryWrapperEdit__box">
            <select class="categoryWrapperEdit__box--select" id="child_category_edit" name="">
              <option value="---" data-category="---">---</option>
              ${insertHTML}
            </select>
          </div>
        </div>`;
    $('.showCategoryEditDetail').append(childSelectHtml);
  }

// 孫カテゴリー用のhtmlを作成。
  function appendGrandChildrenBox(insertHTML) {
    var grandchildSelectHtml = '';
    grandchildSelectHtml = 
          `<div class='categoryWrapperEdit' id= 'grandchildren_wrapper_edit'>
            <div class="categoryWrapperEdit__box">
              <select class="categoryWrapper__box--select" id="grandchild_category_edit" name="item[category_id]">
                <option value="---" data-category="---">---</option>
                ${insertHTML}
              </select>
            </div>
          </div>`;
    $('.showCategoryEditDetail').append(grandchildSelectHtml);
  }

// 親カテゴリー変更時のイベント
  $('#parent_category_edit').on('change', function() {
// 親カテゴリーのデータを取得して変数にいれる
    var parentCategoryEdit = document.getElementById('parent_category_edit').value;
    if (parentCategoryEdit != '---'){
// ajaxの処理
      $.ajax({
        url: 'get_category_children',
        type: 'GET',
        data: { parent_id: parentCategoryEdit },
        dataType: 'json'
      })
      // 成功した時の処理
      .done(function(children){
// 元々あった子カテゴリーと孫カテゴリーを消す。
        $('#child_category_edit').remove();
        $('#grandchild_category_edit').remove();
        var insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
// オプション付きのinsertHTMLをappendChildにいれる。
        appendChildrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else {
      $('#child_category_edit').remove();
      $('#grandchild_category_edit').remove();
    }
  });

  //子カテゴリーとやっていることは基本的に同じです 
  $('.showCategoryEditDetail').on('change', '#child_category_edit', function(){
    var childIdEdit = document.getElementById('child_category_edit').value;
    if (childIdEdit !== "---") {
      $.ajax({
        url: 'get_category_grandchildren',
        type: 'GET',
        data: { child_id: childIdEdit },
        dataType: 'json'
      })
      .done(function(grandchildren) {
        if (grandchildren.length != 0) {
          $('#grandchild_wrapper_edit').remove();
          var insertHTML = '';
          grandchildren.forEach(function(grandchild){
            insertHTML += appendOption(grandchild);
          });
          appendGrandChildrenBox(insertHTML);
        }
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else {
      $('#grandchild_wrapper_edit').remove();
    }
  })
})