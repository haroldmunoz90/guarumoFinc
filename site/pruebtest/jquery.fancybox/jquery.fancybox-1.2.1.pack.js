function $(id){
	return document.getElementById(id);	
	
}
function DisplayError(errnum,emessage,etips){
	$("id_error").style.display = "block";//id为id_error的对象的display（显示）方式为block（显示）
	if(errnum=="0"){                                           //如果错误号码为0
		$("id_error").innerHTML="<ul class='errorlist'><li>"+emessage+"</li><li>"+etips+"</li></ul>";
	}
}
var fingertemplate="";//从文件中读取获得的指纹模板
var VerifyTemplate="";//从指纹登记中页面中获取的指纹模板
function submitFinger(action){
	$("id_error").style.display = "block";//id为id_error的对象的display（显示）方式为block（显示）
	$("form1").target="showMsg"
	if(action=="checkFinger"){
		$("form1").action="checkFinger.jsp";//form1的action属性为checkFinger.jsp
		$("hiddenObj").name="VerifyTemplate";//hiddenObj的name属性为VerifyTemplate
	}
	if(action=="regFinger"){
		$("form1").action="regFinger.jsp";
		$("hiddenObj").name="hiddenObj";
	}
	if($("username").value==""&&action=="regFinger"){
		alert("请输入用户名");
		$("username").focus();//username输入框获得焦点
	}else{
		$("showMsg").width=300;
		$("showMsg").height=36;
		$("form1").submit();
	} 
}
function checkFinger(){//指纹对比模块js
	if (navigator.appName == "Microsoft Internet Explorer")	{
			if (typeof zkonline.RegisterTemplate != "undefined") {
				if (zkonline.GetVerTemplate()){
					VerifyTemplate=zkonline.VerifyTemplate; 

				}else{
					VerifyTemplate="";				
					return;
				}	
			} else {
					var errnum = "0";
			    	var emessage = "登记失败.";
			    	var etips = "请检查确认已安装ZKOnline客户端和指纹设备已连接.";
		    		DisplayError(errnum,emessage,etips);
		    		return;
			}
		} else {
			if (window["zkonline"]) {
				if (zkonline.GetVerTemplate()){
					VerifyTemplate=zkonline.VerifyTemplate;
				}else{
					VerifyTemplate="";
					return;	
				}
			} else {
		            var errnum = "0";
			        var emessage = "登记失败.";
			        var etips = "请检查确认已安装ZKOnline客户端和指纹设备已连接.";
		    		DisplayError(errnum,emessage,etips);
		    		return;
			}
		}
	form1.hiddenObj.value=VerifyTemplate;
	submitFinger("checkFinger")
}
function RegFinger(){                                           //指纹登记js
	var RegisterTemplate=[];                                    //定义指纹模板数组，接收需要注册的指纹模板。
	var fingerids=[];                                          //定义手指id数组，接收手指id	
	if (navigator.appName == "Microsoft Internet Explorer")	{
			if (typeof zkonline.RegisterTemplate != "undefined") {
				if (zkonline.Register()){
					for(i=1;i<=10;i++){
						if(zkonline.GetRegFingerTemplate(i).length>2){//判断获取的指纹模板长度是否大于2
							fingerids.push(i);                         //将手指id放入fingerids数组
							RegisterTemplate.push(zkonline.GetRegFingerTemplate(i));	//将获取的指纹模板放入指纹登记数组
						}						
						
					}
					zkonline.RegisterTemplate="";//清空临时接收模板
				}else{
					RegisterTemplate="";				
					return;
				}	
			} else {
					var errnum = "0";
			    	var emessage = "登录失败.";
			    	var etips = "请检查确认已安装ZKOnline客户端和指纹设备已连接.";
		    		DisplayError(errnum,emessage,etips);
		    		return;
			}
		} else {
			if (window["zkonline"]) {
				if (zkonline.Register()){
					RegisterTemplate=zkonline.RegisterTemplate;
					zkonline.RegisterTemplate="";
				}else{
					RegisterTemplate="";
					return;	
				}
			} else {
					var errnum = "0";
			        var emessage = "登录失败.";
			        var etips = "请检查确认已安装ZKOnline客户端和指纹设备已连接.";
		    		DisplayError(errnum,emessage,etips);
		    		return;
			}
		}
	$("hiddenObj").value=RegisterTemplate;
	$("finghidden").value=fingerids;
	submitFinger("regFinger")
}

function Load(){								//页面加载js
	var fingerLogin = $("fingerLogin");
	var regFinger=$("regFinger");
	var username=$("username");
	fingerLogin.onclick=(function(){
		username.blur();
		checkFinger();	
	});
	regFinger.onclick=(function(){
		username.onblur="";
		if(username.value==""){
			alert("请先输入用户名");
			username.focus();
		}else{
			RegFinger();	
		}
	});
};
