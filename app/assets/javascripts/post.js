$(document).ready(function() {
  $('.new_post').submit(function(event){
    event.preventDefault();
    var self = $(this);
    var params = self.serialize();
    $.ajax({
      url: self.attr('action'),
      type: 'POST',
      data: params,
      dataType: 'json',
      success: function(response) {
        if(response.status == 'success'){
          $(".posts").prepend(response.html);
          $('#post_title').val('');
          $('#post_content').val('');
        }
      },
      error: function (){
        alert(I18n.t('.error'));
      }
    });
    return false;
  });

  $('body').on('click', '.delete-micropost', function(event){
    event.preventDefault();
    var self = $(this);
    var params = self.serialize();
    $.ajax({
      type: 'DELETE',
      url: self.attr('href'),
      data: params,
      dataType: 'json',
      success: function(response) {
        if(response.status == 'success'){
          self.closest('.post-id').hide();
        }
      },
      error: function (){
        alert(I18n.t('.error'));
      }
    });
    return false;
  });
});
