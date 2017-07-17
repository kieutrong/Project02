$(document).ready(function(){
  $('body').on('click', '#edit_comment', function(event) {
    event.preventDefault();
    var self = $(this);
    var comment_id = $(this).data('id');
    var url = $(this).attr('href');
    $.ajax({
      type: 'GET',
      dateType: 'json',
      url: url,
      success: function(data){
        $('#comment_submit').attr('id', 'update-comment');
        self.next().after(data.html)
      },
      error: function (){
        alert(I18n.t('.error'));
      }
    });
  });

  $('body').on('submit', '.update-comment', function(event) {
    event.preventDefault();
    var self = $(this);
    var comment_id = self.data('id');
    var url = self.attr('action');
    var params = self.serialize();
    $.ajax({
      type: 'PATCH',
      dateType: 'json',
      data: params,
      url: url,
      success: function(data){
        $('#edit_comment_' + comment_id).remove();
        $('#comment_' + comment_id).html(data.html);
      },
      error: function (){
        alert(I18n.t('.error'));
      }
    });
    return false;
  });
});
