
// captcha

var captcha = {};


captcha.group = {};
captcha.reloadUrl = '';
captcha.picPath = '';



// reload
captcha.reload = function ( captchaId, opt_needFocus ) {
	var needFocus = true;
	if ( arguments.length == 2 ) {
		needFocus = opt_needFocus;
	}

	$.ajax({
		url: captcha.reloadUrl,
		dataType: 'json',
		type: 'post',
		success: function ( response ) {
			switch ( response.result ) {
				case 'OK':
					captcha.group[captchaId].btn.removeClass ( 'transparent' );
					captcha.group[captchaId].pic.attr ( 'src', captcha.picPath + response.code + '.jpg' );
					captcha.group[captchaId].hash.val ( response.code );
					var field = captcha.group[captchaId].field;
					field.val ( '' );
					if ( needFocus ) {
						field.focus();
					}
					break;
				default:
					popup.show ( response.result + ': ' + response.answer );
			}
			
		}
	});
};


// init
captcha.init = function ( reloadUrl, picPath ) {

	// set reload url and pic path
	captcha.reloadUrl = reloadUrl;
	captcha.picPath = picPath;

	// reload btn click
	$( 'input.captcha-reload-btn' ).each ( function () {

		// fill captcha group
		var id = $(this).attr ( 'id' );
		var clearId = id.replace ( 'captcha_reload_btn', '' );
		captcha.group[id] = {};
		captcha.group[id].btn = $(this);
		captcha.group[id].hash = $( '#captcha_hash' + clearId );
		captcha.group[id].pic = $( '#captcha_pic' + clearId );
		captcha.group[id].field = $( '#captcha' + clearId );

		// add btn click
		$(this).click ( function () {
			$(this).addClass ( 'transparent' );
			captcha.reload ( $(this).attr ( 'id' ) );
		});
	});

};