//= require jquery_ujs
//= require foundation
//= require wysiwym/wysiwym


// For the Live Preview we want to check the value of
// textarea changes as some set interval.  If it's
// changed, we'll call Showdown to convert the textarea
// input to HTML then prettify to colorize code blocks.
var prev_text = "";
function parse_live(node, preview) {
    var input_text = node.val();
    if (input_text !== prev_text) {
        var showdown = new Showdown.converter();
        preview.html(showdown.makeHtml(input_text));
        Prism.highlightAll()
        prev_text = input_text;
    }
}
function parse_once(node){
    var showdown = new Showdown.converter();
    node.html(showdown.makeHtml(node.text()));
    Prism.highlightAll()
}

// Setup the WYSIWYM editor!
jQuery(window).load(function() {
  jQuery("[data-parse]").each(function(i, node){
    var $node = jQuery(node);
    if($node.attr("data-parse") === "once"){
      parse_once($node);
    }else if($node.attr("data-parse") === "live"){
      setInterval(function(){
        parse_live($node, jQuery($node.attr("data-parse-preview")));
      }, 200);
    }
  });
});

$(function(){ $(document).foundation(); });
