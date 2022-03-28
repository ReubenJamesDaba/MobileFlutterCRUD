var baseurl = window.location.origin;
var host = window.location.host;
var pathArray = window.location.pathname.split( '/' )[1];
// var base_url = baseurl+'/'+pathArray+'/';

var base_url = baseurl+'/';


if(base_url =='http://localhost/'){
    var base_url = baseurl+'/'+pathArray+'/';
}else{
    var base_url = baseurl+'/';
}
var url;
var data;
function ajax_save(url,data){
    $.ajax({
        method: "POST",
        url : base_url+url,
        data : data
    }).done(function(res){
        var ress =  jQuery.parseJSON(res);
        return res;
    }).fail(function(){
        console.log("An error occurred, the files couldn't be sent!");
    });
}