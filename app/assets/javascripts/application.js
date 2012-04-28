//= require jquery
//= require jquery_ujs
//= require google-code-prettify/prettify
//= require showdown/showdown
//= require wysiwym/wysiwym


// For the Live Preview we want to check the value of
// textarea changes as some set interval.  If it's
// changed, we'll call Showdown to convert the textarea
// input to HTML then prettify to colorize code blocks.
var showdown = new Showdown.converter();
var prev_text = "";
var parse_live = function(node, preview) {
    var input_text = node.val(); //$('#post_body')
    if (input_text != prev_text) {
        var text = $("<div>"+ showdown.makeHtml(input_text) +"</div>");
        text.find('pre').addClass('prettyprint linenums');
        text.find('p code').addClass('prettyprint');
        text.find('pre').each(function() {
            $(this).html(prettyPrintOne($(this).html(), undefined, true));
        });
        text.find('p code').each(function() {
            $(this).html(prettyPrintOne($(this).html()));
        });
        preview.html(text); //$('#post_body_preview')
        prev_text = input_text;
    }
};
var parse_once = function(node){
    var text = $("<div>"+ node.html() +"</div>");
    text.find('pre').addClass('prettyprint linenums');
    text.find('p code').addClass('prettyprint');
    text.find('pre').each(function() {
        $(this).html(prettyPrintOne($(this).html(), undefined, true));
    });
    text.find('p code').each(function() {
        $(this).html(prettyPrintOne($(this).html()));
    });
    node.html(text);
};

// Setup the WYSIWYM editor!
jQuery(window).load(function() {
  jQuery("[data-parse]").each(function(i, node){
    var $node = jQuery(node);
    if($node.attr("data-parse") == "once"){
      parse_once($node);
    }else if($node.attr("data-parse") == "live"){
      setInterval(function(){
        parse_live($node, jQuery($node.attr("data-parse-preview")));
      }, 200);
    }
  });
});
