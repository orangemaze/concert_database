function add_remove_albums_to_band(action) {
    var locale = window.location.pathname.substring(0, 3);
    if(locale = '/'){
        locale = '/en'
    }

    var tours_id = document.getElementById('tours_id').value;
    var band_id = document.getElementById('band_id').value;
    var str = document.getElementById('concert_available_tour').value;

    var selectedArray = new Array();
    if (action == 'add'){
        var selObj = document.getElementById('concert_available_tour');
    }
    else{
        var selObj = document.getElementById('concert_in_tour');
    }
    var i;
    var count = 0;
    for (i=0; i<selObj.options.length; i++) {
        if (selObj.options[i].selected) {
            selectedArray[count] = selObj.options[i].value;
            count++;
        }
    }
    var url = locale+ '/albums/add_remove_album_to_band/'+band_id+'?user_action='+action+'&choice=' + selectedArray;
    //alert(selectedArray);
    // alert(url);
    $.get(url, function(data, status){
        $("#concerts_in_tour").html(data);
    });



}
