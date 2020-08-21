// カテゴリーセレクトボックスのオプションを作成
$(function(){
  function appendOption(category){
    var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  // 子カテゴリーの表示作成
  function appendChildrenBox(insertHTML){
    var childSelectHtml = '';
    childSelectHtml = 
        `<div class='categoryWrapper' id= 'children_wrapper'>
          <div class='categoryWrapper__box'>
            <select class='categoryWrapper__box--select' id="child_category" name="item[category_id]">
              <option value="---" data-category="---">---</option>
              ${insertHTML}
            </select>
          </div>
        </div>`;
    $('.showCategoryDetail').append(childSelectHtml);
  }
  // 孫カテゴリーの表示作成
  function appendGrandChildrenBox(insertHTML){
    var grandchildSelectHtml = '';
    grandchildSelectHtml = 
          `<div class='categoryWrapper' id= 'grandchildren_wrapper'>
            <div class='categoryWrapper__box'>
              <select class='categoryWrapper__box--select' id="grandchild_category" name="item[category_id]">
                <option value="---" data-category="---">---</option>
                ${insertHTML}
              </select>
            </div>
          </div>`;
    $('.showCategoryDetail').append(grandchildSelectHtml);
  }
  // 親カテゴリー選択後のイベント
  $('#parent_category').on('change', function(){
    var parentCategory = document.getElementById('parent_category').value;
    if (parentCategory != "---"){
      $.ajax({
        url: 'get_category_children',
        type: 'GET',
        data: { parent_id: parentCategory },
        dataType: 'json'
      })
      .done(function(children){
        //親が変更された時、子以下を削除
        $('#children_wrapper').remove();
        $('#grandchildren_wrapper').remove();
        var insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChildrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#children_wrapper').remove();
      $('#grandchildren_wrapper').remove();
    }
  });
  // 子カテゴリー選択後のイベント
  $('.showCategoryDetail').on('change', '#child_category', function(){
    var childId = $('#child_category option:selected').data('category');
    if (childId != "---"){
      $.ajax({
        url: 'get_category_grandchildren',
        type: 'GET',
        data: { child_id: childId },
        dataType: 'json'
      })
      .done(function(grandchildren){
        if (grandchildren.length != 0) {
          $('#grandchildren_wrapper').remove();
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
    }else{
      $('#grandchildren_wrapper').remove();
    }
  });
});