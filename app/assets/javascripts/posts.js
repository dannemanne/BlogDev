$(function(){
  $('[data-toggle]').click(function(){
    $node = $('#'+this.getAttribute('data-toggle'));
    if($node.is(':visible')){
      $node.fadeOut();
    }else{
      $node.fadeIn();
    }
  });
});
