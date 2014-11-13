$(function() {
	// 要素の取得方法は、$("要素名")
	$('.favorite-btn').click(function() {
		$(this).children('.favorite-users').show();
		var clickedElement = event.target;
	    if($(clickedElement).hasClass('favorite-users')){
	        $('.favorite-users').hide(200);
	    }
	});
});