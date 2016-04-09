<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>RegFinger</title>
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
<body onUnload="unload()">
<font class="msg">

<?php
	//String RegisterTemplate="";

	String path=request.getRealPath(".");                //��õ�ǰ�ļ���·��
	path=path+"\\fingerList.xml";
	String tmp="";
	int isExit=0;
	String RegisterTemplate="";
	String NumFinger="";
	String username=new String();
	String NumId[]=new String[10];
	String fingers[]=new String[10];
	if(request.getParameter("username")!=null)//�ж�ҳ��������û����Ƿ�Ϊ��
		username=request.getParameter("username"); 
	if(request.getParameter("hiddenObj")!=null){//�ж�ҳ�������ָ��ģ����Ϣ�Ƿ�Ϊ��
		RegisterTemplate=request.getParameter("hiddenObj");
	}
	System.out.println(RegisterTemplate);
	if(request.getParameter("finghidden")!=null){//�ж�ҳ���������ָid�Ƿ�Ϊ��
		NumFinger=request.getParameter("finghidden");
	}
	fingers=RegisterTemplate.split(",");//����ȡ��ָ��ģ��ָ������
	NumId=NumFinger.split(",");//����ȡ����ָid�ָ������
	for(int i=0;i<fingers.length;i++){//��ݻ�ȡ����ָ����ѭ������ָ��ģ��д���ļ�
	
?>

<!--<jsp:useBean id="JavaToBiokey" class="zk.jni.JavaToBiokey" scope="page"></jsp:useBean>-->
<jsp:useBean id="reader" class="writeApp.DelimitedDataFile" scope="page">
<jsp:setProperty name="reader" property="path" value="<%=path%>" />
</jsp:useBean>
<%
	Pattern p = Pattern.compile("\\s*|\t|\r|\n");
	
	while (reader.nextRecord() != -1) {//����ļ����Ƿ����û������ָidͬʱ��ȵ��û�
		tmp=reader.returnRecord();
		Matcher m = p.matcher(tmp);
		tmp = m.replaceAll("");
		if(tmp.indexOf("@")!=-1){
			//out.print(username1.substring(0,username1.indexOf("@")));
			if(tmp.substring(0,tmp.indexOf("@")).equals(username)){
				if(NumId[i].equals(tmp.substring(tmp.indexOf("#")+1))){
					isExit=1;
				}
			}
		}
	}
	}
	if(isExit==1){
		out.print("���û���ĸ�ָ���Ѵ���");
	} else{
%>��

<jsp:useBean id="writer" class="writeApp.WriteAppend" scope="request">
��<jsp:setProperty name="writer" property="path" value="<%=path%>" />
��<jsp:setProperty name="writer" property="something" value="Something already set as a property in WriteAppend" />
</jsp:useBean>
<%
    for(int i = 0;i<fingers.length;i++){//ѭ����ָ����Ϣд���ַ�str
    		writer.setSomething(username+"@"+fingers[i]+"#"+NumId[i]);
    		writer.writeSomething();
    		String enter = "\r\n";
    		writer.setSomething(enter);
    		writer.writeSomething();
    		//System.out.print(writer.getSomething()); 
    	
    }	
	out.print("ָ���ѳɹ����浽��������"); 
}	
 %>
</font>
</body>
</html>
