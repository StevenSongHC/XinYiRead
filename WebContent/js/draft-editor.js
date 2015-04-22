/**
 * Script for draft editing action
 */

$(document).ready(function() {
	/*$("#draft-stage").keypress(function (e) {
		if (e.keyCode == 13) {		// 'ENTER' pressed
			e.preventDefault();
			$(this).append("<p><br></p>");
		}
		if (e.keyCode == 32) {
			//e.preventDefault();
		}
	});*/
	/*$("#draft-stage").keydown(function(e) {
		$("#tmp").focus();
	});
	$("#tmp").keyup(function(e) {
		$("#draft-stage").focus();
	});*/
	$("#draft-stage").bind("input oninput", function(e) {
		//$("#tmp").val($(this).html().trim().replace(/<(?!br|p).*?>/ig, ""));
		/*$(this).find("*").each(function() {
			$("#tmp").val($("#tmp").val() + "<p>" + $(this).html().replace(/<(?!br).*?>/ig, "") + "</p>");
		});*/
		/*$(this).find("*").each(function() {
			$("#tmp").val($("#tmp").val() + $(this).html().replace(/<(?!br).*?>/ig, ""));
		});*/
		
		$(this).find("*:not(br,p)").each(function() {
			var str = stripMark($(this));
			$(this).after("<p>" + str + "</p>");
			$(this).remove();
			//$(this).html("<p>" + $(this).html().replace(/<(?!br).*?>/ig, "") + "</p>");
			//$(this).html(stripMark($(this)));
		});
		//$(this).html($("#tmp").val());
		
		//$("#tmp").val($(this).text());
		/*stripMark($(this));
		console.log($(this).html());*/
	});
});

/*function stripMark(e) {
	$(e).find("*:not(br,p)").each(function() {
		$(this).after("<p>" + $(this).html() + "</p>");
		$(this).remove();
	});
	stripMark(e);
}*/

function stripMark(e) {
	var str = $(e).html();
	$(e).find("*").each(function() {
		console.log($(this).html());
		str += stripMark($(this));
		$(this).remove();
	});
	return str;
}

/*$.fn.setCursorPosition = function(position){  
    if(this.lengh == 0) return this;  
    return $(this).setSelection(position, position);  
}  
  
$.fn.setSelection = function(selectionStart, selectionEnd) {  
    if(this.lengh == 0) return this;  
    input = this[0];  
  
    if (input.createTextRange) {  
        var range = input.createTextRange();  
        range.collapse(true);  
        range.moveEnd('character', selectionEnd);  
        range.moveStart('character', selectionStart);  
        range.select();  
    } else if (input.setSelectionRange) {  
        input.focus();  
        input.setSelectionRange(selectionStart, selectionEnd);  
    }  
  
    return this;  
}  
  
$.fn.focusEnd = function(){  
    this.setCursorPosition(this.val().length);  
}  */