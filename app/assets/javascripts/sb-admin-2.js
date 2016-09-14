$(function() {

    $('#side-menu').metisMenu();

});


$( ".change_to" ).click(function() {
    member_id = this.id;
    $(".change_member_"+member_id).html(member_id);
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

$("#admin_edit_control").click(function(){
    $(".admin_edit").toggle();
    $( "#admin_edit_control" ).toggleClass( "reverse" );
});

$("[data-toggle=popover]").popover({html : true});

function merge_members(current_id){
    var merged_id = $( "#merged_id" ).val();
    var locale = window.location.pathname.substring(0, 3);
    $.get(locale + "/members/merge_members/"+current_id+"?merged_id="+merged_id, function( data ) {
        if(data.replace(/^\s\s*/, '').replace(/\s\s*$/, '') == "complete"){
            $('.popover').popover('hide');
        }
        else {
            $("#error_message").html("<br> error"+data+"!");
        }
    });
}

$(".roio-details").click(function(){
    var bootleg_id = $(this).attr("id")
    // var locale = get_query_string_params('locale');
    var locale = window.location.pathname.substring(0, 3);
    $.get(locale + "/concerts/roio_details/"+bootleg_id, function(data, status){
        // roio-details-container
        $("#roio-details-container").html(data);
        // alert("Data: " + data + "\nStatus: " + status);
    });
});
function change_search(category){
    $( "#action_button" ).html(category+" <span class=\"caret\"></span>");
    if(category == "Concerts"){
        $("#suggest").attr("placeholder", "yyyy-mm-dd");
    }
    else{
        $("#suggest").attr("placeholder", "");
    }
    $( "#action_button" ).val(category);
}

function get_query_string_params(sParam){
    var sPageURL = window.location.search.substring(1);
    var sURLVariables = sPageURL.split('&');
    for (var i = 0; i < sURLVariables.length; i++){
        var sParameterName = sURLVariables[i].split('=');
        if (sParameterName[0] == sParam){
            return sParameterName[1];
        }
    }
}

function delete_tour_member(tours_id, member_id){
    var locale = window.location.pathname.substring(0, 3);
    $.get(locale + "/tour_member/delete_member_from_tour/?tours_id="+tours_id+"&member_id="+member_id, function(data, status){
        // roio-details-container
        $("#tour-member-container").html(data);
        // alert("Data: " + data + "\nStatus: " + status);
    });
}

var optionText, array = [], newString, maxChar = 40;
$('select').each(function(){
    $(this).find('option').each(function(i,e) {
        $(e).attr('title',$(e).text());
        optionText = $(e).text();
        newString = '';
        if (optionText.length > maxChar) {
            array = optionText.split(' ');
            $.each(array,function(ind,ele) {
                newString += ele+' ';
                if (ind > 0 && newString.length > maxChar) {
                    $(e).text(newString);
                    return false;
                }
            });

        }
    });
});

function go_to_concert_selected(str){
    var concert_in_tour_js = document.getElementById('concert_in_tour').value;
    var locale = window.location.pathname.substring(0, 3);
    if(locale = '/'){
        locale = '/en'
    }
    var url_to_open = locale+'/concerts/'+concert_in_tour_js;
    // alert(url_to_open);
    window.open (url_to_open,'_self',false)
}

function add_remove_concerts_to_tour(action) {
    var locale = window.location.pathname.substring(0, 3);
    if(locale = '/'){
        locale = '/en'
    }

    var tours_id = document.getElementById('tours_id').value;
    var band_id = document.getElementById('band_id').value;
    var str = document.getElementById('concert_available_tour').value;

    var selectedArray = new Array();
    var selObj = document.getElementById('concert_available_tour');
    var i;
    var count = 0;
    for (i=0; i<selObj.options.length; i++) {
        if (selObj.options[i].selected) {
            selectedArray[count] = selObj.options[i].value;
            count++;
        }
    }
    var url = locale+ '/tours/add_remove_concert_to_tour/'+tours_id+'?band_id='+band_id+'&user_action='+action+'&choice=' + selectedArray;
    //alert(selectedArray);
    // alert(url);
    $.get(url, function(data, status){
        $("#concerts_in_tour").html(data);
    });



}

