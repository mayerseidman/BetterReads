$(document).ready(function(){
	$('#sign-in').on('click', function (e) {
		var email = $('#email').val();
		$.ajax({
		        type: "POST",
		        url: "/users/email",
		        data: { email: email },
		        success: function(msg){

		        }
		});
	});
});
