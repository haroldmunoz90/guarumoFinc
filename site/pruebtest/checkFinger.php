<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,java.io.*,java.util.regex.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�ޱ����ĵ�</title>
<style>
.msg{
	font-size:24;
	color: #FF0000
}
</style>

<script type="text/javascript" src="jquery.fancybox/jquery-1.3.2.min.js"></script>
<script>
function unload(){
	window.parent.stopLoading();
};
</script>
</head>

<body unload="unload()">
<font class="msg">
<%
	String path=request.getRealPath(".");                //��õ�ǰ�ļ���·��
	path=path+"\\fingerList.xml";
 %>
<!--<jsp:useBean id="JavaToBiokey" class="zk.jni.JavaToBiokey" scope="page"></jsp:useBean>-->
<jsp:useBean id="reader" class="writeApp.DelimitedDataFile" scope="page">
��<jsp:setProperty name="reader" property="path" value="<%=path%>" />
</jsp:useBean>

<% int count = 0; %> 
<%
	String VerifyTemplate="";
	if(request.getParameter("VerifyTemplate")!=null)//�ж�ҳ�������ָ��ģ����Ϣ�Ƿ�Ϊ��
		VerifyTemplate=request.getParameter("VerifyTemplate"); 
	Pattern p = Pattern.compile("\\s*|\t|\r|\n");
	String finger="";//
	String username1="";

	int result=0;
	while (reader.nextRecord() != -1) {//ѭ�������ļ�������û����Ƿ���ںͽ��յ�ָ��ģ����ͬ���û��������û�����ֵ��username1
		count++;
		finger=reader.returnRecord();
		System.out.print(finger);
		Matcher m = p.matcher(finger);
		finger = m.replaceAll("");
		if(finger.indexOf("@")!=-1){				
			if(zk.jni.JavaToBiokey.NativeToProcess(finger.substring(finger.indexOf("@")+1,finger.indexOf("#")),VerifyTemplate)){
				username1=finger.substring(0,finger.indexOf("@"));
				result=1;
			}
		}
	}
	if(result==1){
		out.print("ָ�ƶԱȳɹ����û�����"+username1);
	}else{
		out.print("ָ�Ʋ�ƥ��");
	}
%>��

</font>
</body>
</html>
