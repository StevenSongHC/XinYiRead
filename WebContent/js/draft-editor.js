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
		/*$("#tmp").val($(this).find("p:last").html());
		//$("#draft-stage>p:last").html($("#tmp").val());
		$(this).find("p:last").html("");
		var newContent = $("#tmp").val();
		console.log(newContent);
		if (newContent == "<br>")
			$(this).find("p:last").html(newContent);
		else
			$(this).find("p:last").html(newContent.replace(/<[^>]+>/g, ""));
		*/
		//$(this).focusEnd();
		console.log(e);
		console.log($("#draft-stage").html());
	});
});


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