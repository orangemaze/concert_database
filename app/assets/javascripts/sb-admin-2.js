$(function() {

    $('#side-menu').metisMenu();

});


$( "#login" ).click(function() {
    var username = $("#username").val();
    var password = $("#password").val();
    var from_what_page = $("#from_what_page").val();
    if ($("#remember_me").is(':checked')){
        var remember_me = 'yes';
    }
    else{
        var remember_me = 'no';
    }

    $.get( "/login/login?username="+username+"&password="+password+"&remember_me="+remember_me+"&from_what_page="+from_what_page, function( data ) {
        // alert(data);
        window.open(data,"_self");
    });
});

$( "#logout" ).click(function() {
    $.get( "/login/logout", function( data ) {
        // alert('logged out');
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
