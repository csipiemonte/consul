// Overrides and adds customized javascripts in this file
// Read more on documentation: 
// * English: https://github.com/consul/consul/blob/master/CUSTOMIZE_EN.md#javascript
// * Spanish: https://github.com/consul/consul/blob/master/CUSTOMIZE_ES.md#javascript
//
// 
$(document).ready(function() { 
	var contenitore =$(".top-bar .top-bar-title > a");  
	var contenitore1 =$("a.logo");   
	var nthChar = 6; 
	var text = contenitore.text().trim();
	var text_corr = text.substr(0, nthChar-1) + "<span class='irossa'>" + text.substr(nthChar -1, 1) + "</span>" + 	text.substr(nthChar);	
	var $img = contenitore.find('img'); 
	contenitore.text('');contenitore1.text('');	
	if (text.length > nthChar+1 && text.substr(0, nthChar+1).indexOf("<") === -1) {
		contenitore.append($img).append(text_corr);
		contenitore1.append(text_corr);
	}
	
	$('#responsive-menu').attr('style','display:block');
});

