// JavaScript Document


function println(str){
	$("body").append(str+"<br>");
}


function marke(){
    $("body").append("<div id='marke'></div>");
	$("#marke").show();
	var w=$(window).width();
	var h=$(window).height();
	
	$("#marke").css({"background":"#000000",
					"position":"absolute",
					"top":"0px",
					"width":w,
					"height":h,
					"z-index":"100",
					"filter":"progid:DXImageTransform.Microsoft.Alpha(opacity=50)"
					});
	
	
}

function unmarke(){
	$("#marke").hide();
}



//写cookies函数 作者：翟振凯
function setCookie(name,value)//两个参数，一个是cookie的名子，一个是值
{
	
	var nextyear = new Date();  
    nextyear.setFullYear(nextyear.getFullYear()+1);
    document.cookie = name + "="+ escape (value) + ";expires=" + nextyear.toGMTString();
}
function getCookie(name)//取cookies函数        
{
    var arr = document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
     if(arr != null) return unescape(arr[2]); return null;

}
function delCookie(name)//删除cookie
{
    var exp = new Date();
    exp.setTime(exp.getTime() - 1);
    var cval=getCookie(name);
    if(cval!=null) document.cookie= name + "="+cval+";expires="+exp.toGMTString();
}