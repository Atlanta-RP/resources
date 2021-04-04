$(document).ready(function(){
	window.addEventListener("message",function(event){
		var html = "<div id='"+event.data.css+"' class='gradient-border'>"+event.data.mensagem+"</div>"
		$(html).fadeIn(900).appendTo("#notifications").delay(event.data.timer).slideUp("slow");
	})
});