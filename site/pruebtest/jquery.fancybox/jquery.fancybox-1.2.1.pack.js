function $(id){
	return document.getElementById(id);	
	
}
function DisplayError(errnum,emessage,etips){
	$("id_error").style.display = "block";//idΪid_error�Ķ����display����ʾ����ʽΪblock����ʾ��
	if(errnum=="0"){                                           //����������Ϊ0
		$("id_error").innerHTML="<ul class='errorlist'><li>"+emessage+"</li><li>"+etips+"</li></ul>";
	}
}
var fingertemplate="";//���ļ��ж�ȡ��õ�ָ��ģ��
var VerifyTemplate="";//��ָ�ƵǼ���ҳ���л�ȡ��ָ��ģ��
function submitFinger(action){
	$("id_error").style.display = "block";//idΪid_error�Ķ����display����ʾ����ʽΪblock����ʾ��
	$("form1").target="showMsg"
	if(action=="checkFinger"){
		$("form1").action="checkFinger.jsp";//form1��action����ΪcheckFinger.jsp
		$("hiddenObj").name="VerifyTemplate";//hiddenObj��name����ΪVerifyTemplate
	}
	if(action=="regFinger"){
		$("form1").action="regFinger.jsp";
		$("hiddenObj").name="hiddenObj";
	}
	if($("username").value==""&&action=="regFinger"){
		alert("�������û���");
		$("username").focus();//username������ý���
	}else{
		$("showMsg").width=300;
		$("showMsg").height=36;
		$("form1").submit();
	} 
}
function checkFinger(){//ָ�ƶԱ�ģ��js
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
			    	var emessage = "�Ǽ�ʧ��.";
			    	var etips = "����ȷ���Ѱ�װZKOnline�ͻ��˺�ָ���豸������.";
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
			        var emessage = "�Ǽ�ʧ��.";
			        var etips = "����ȷ���Ѱ�װZKOnline�ͻ��˺�ָ���豸������.";
		    		DisplayError(errnum,emessage,etips);
		    		return;
			}
		}
	form1.hiddenObj.value=VerifyTemplate;
	submitFinger("checkFinger")
}
function RegFinger(){                                           //ָ�ƵǼ�js
	var RegisterTemplate=[];                                    //����ָ��ģ�����飬������Ҫע���ָ��ģ�塣
	var fingerids=[];                                          //������ָid���飬������ָid	
	if (navigator.appName == "Microsoft Internet Explorer")	{
			if (typeof zkonline.RegisterTemplate != "undefined") {
				if (zkonline.Register()){
					for(i=1;i<=10;i++){
						if(zkonline.GetRegFingerTemplate(i).length>2){//�жϻ�ȡ��ָ��ģ�峤���Ƿ����2
							fingerids.push(i);                         //����ָid����fingerids����
							RegisterTemplate.push(zkonline.GetRegFingerTemplate(i));	//����ȡ��ָ��ģ�����ָ�ƵǼ�����
						}						
						
					}
					zkonline.RegisterTemplate="";//�����ʱ����ģ��
				}else{
					RegisterTemplate="";				
					return;
				}	
			} else {
					var errnum = "0";
			    	var emessage = "��¼ʧ��.";
			    	var etips = "����ȷ���Ѱ�װZKOnline�ͻ��˺�ָ���豸������.";
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
			        var emessage = "��¼ʧ��.";
			        var etips = "����ȷ���Ѱ�װZKOnline�ͻ��˺�ָ���豸������.";
		    		DisplayError(errnum,emessage,etips);
		    		return;
			}
		}
	$("hiddenObj").value=RegisterTemplate;
	$("finghidden").value=fingerids;
	submitFinger("regFinger")
}

function Load(){								//ҳ�����js
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
			alert("���������û���");
			username.focus();
		}else{
			RegFinger();	
		}
	});
};
