$(function(){
  $('[data-toggle]').click(function(evt){
    evt.preventDefault();
    $node = $('#'+this.getAttribute('data-toggle'));
    if($node.is(':visible')){
      $node.fadeOut();
    }else{
      $node.fadeIn();
    }
  });
});
