$(function() {

    $('#side-menu').metisMenu();

});


$( "#login" ).click(function() {
    alert('here');
    var username = $("#username").val();
    var password = $("#password").val();
    if ($("#remember_me").is(':checked')){
        var remember_me = 'yes';
    }
    else{
        var remember_me = 'no';
    }

    $.get( "/login/set_cookies?username="+username+"&password="+password+"&remember_me="+remember_me, function( data ) {
        location.reload();
        // $( "#sign_in" ).html( data );
        // $( "#sign_up" ).html("");
        // $( "#sign_in" ).removeClass( "open" )
        // alert( "Load was performed." );
    });
});

$( "#logout" ).click(function() {
    $.get( "/login/delete_cookies", function( data ) {
        location.reload();
        // $( "#sign_in" ).html( data );
        // alert( "Load was performed." );
    });
});

//Loads the correct sidebar on window load,
//collapses the sidebar on window resize.
// Sets the min-height of #page-wrapper to window size
$(function() {
    $(window).bind("load resize", function() {
        var topOffset = 50;
        var width = (this.window.innerWidth > 0) ? this.window.innerWidth : this.screen.width;
        if (width < 768) {
            $('div.navbar-collapse').addClass('collapse');
            topOffset = 100; // 2-row-menu
        } else {
            $('div.navbar-collapse').removeClass('collapse');
        }

        var height = ((this.window.innerHeight > 0) ? this.window.innerHeight : this.screen.height) - 1;
        height = height - topOffset;
        if (height < 1) height = 1;
        if (height > topOffset) {
            $("#page-wrapper").css("min-height", (height) + "px");
        }
    });

    var url = window.location;
    // var element = $('ul.nav a').filter(function() {
    //     return this.href == url;
    // }).addClass('active').parent().parent().addClass('in').parent();
    var element = $('ul.nav a').filter(function() {
     return this.href == url;
    }).addClass('active').parent();

    while(true){
        if (element.is('li')){
            element = element.parent().addClass('in').parent();
        } else {
            break;
        }
    }
});
