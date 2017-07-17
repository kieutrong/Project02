$(document).ready(function() {
  $('body').on('submit', '.new-comment', function(event){
    event.preventDefault();
    var params = $(this).serialize();
    var self = $(this);
    $.ajax({
      url: self.attr('action'),
      type: 'POST',
      data: params,
      dataType: 'json',
      success: function(response) {
        if(response.status == 'success'){
          self.next().prepend(response.html);
          $('.text-comment').val('');
        }
      },
      error: function (){
        alert(I18n.t('.error'));
      }
    });
    return false;
  });

  $('body').on('click', '.delete-comment', function(event){
    event.preventDefault();
    var params = $(this).serialize();
    var self = $(this);
    $.ajax({
      type: 'DELETE',
      url: self.attr('href'),
      data: params,
      dataType: 'json',
      success: function(response) {
        if(response.status == 'success'){
          self.closest('.user-comment').hide();
        }
      },
      error: function (){
        alert(I18n.t('.error'));
      }
    });
    return false;
  });
});
