<!-------------------------------------------------------------------
                          标准页面服务对象引用
--------------------------------------------------------------------->
<%@ page contentType="text/html;charset=GBK" %>
 
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.bocom.midserv.base.*" %>
<%@ page import="com.bocom.midserv.web.*" %>
<%@ page import="com.bocom.midserv.gz.*" %>
<%@ page import="com.bocom.eb.des.EBDES" %>
<% 
   int i_step_id	= Integer.parseInt(request.getParameter("step_id").trim());
   int i_biz_id		= Integer.parseInt(request.getParameter("biz_id").trim());
	 String cdno = request.getParameter("cardNo"); 
	 
   MidObjectView midObjectView =  new MidObjectView(); 
   if (midObjectView.getMidObjectView(i_biz_id) != true) 
   	System.exit(1);
   
   MidObjectStepView midObjectStepView =  new MidObjectStepView();
   //int maxstep=midObjectStepView.getMaxStepId(i_biz_id);
   
   String dse_sessionId = request.getParameter("dse_sessionId");//获取dse_sessionId
   String loginType = request.getParameter("loginType");
   GzLog log = new GzLog("c:/gzLog");
   log.Write("step1:	loginType=["+loginType+"] 业务：i_biz_id=["+i_biz_id+"]");  
   
  String cssFileName = request.getParameter("cssFileName");//获取客户当前使用的CSS样式
	if(cssFileName ==null){
		cssFileName = "skin.css";
	}		
%>

<!-------------------------------------------------------------------
                          标准JavaScript库引用
--------------------------------------------------------------------->
<script language="JavaScript" src="/personbank/HttpProxy?URL=/midserv/js/public.js&dse_sessionId=<%=dse_sessionId%>"></script>
<script language="JavaScript" src="/personbank/HttpProxy?URL=/midserv/js/public_card.js&dse_sessionId=<%=dse_sessionId%>"></script>

<!--------------------------------------------------------------------
   当前页面JavaScript函数部分，包括提交验证，页面动作，具体目标等代码
---------------------------------------------------------------------->
<%
//检测输入
out.print(midObjectView.writeCondition(i_biz_id,i_step_id));
//i_step_id=i_step_id+1;
%>

<!--------------------------------------------------------------------
                          页面HTML表现部分    
---------------------------------------------------------------------->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>交通银行网上服务</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" type="text/css" href="/personbank/css/<%=cssFileName%>">

<SCRIPT language=javascript event=onkeydown for=document>   
if( event.keyCode == 13 )
{   
	return false ;
}   
</SCRIPT> 
<script language=JavaScript>
var clickBoolean = true;
var biz_id = <%=i_biz_id%>
function beforeSubmit()
{
	if( biz_id == 7 )
	{		
		if( document.form1.CTSQ.value.length != 11 )
		{
			alert( "手机号长度必须为11" ) ;
			return false ;
		}
		if( document.form1.passWord.value.length != 6 )
 		{
			alert("移动密码为6位数字");		
			return false;
 		}
	}
	if( biz_id == 8 )
	{
		if( document.form1.busiType.value == "03" && document.form1.CTSQ.value.length < 8 )
		{
			alert( "号码长度非法" ) ;
			return false ;
		}
		
		if( document.form1.busiType.value != "03" && document.form1.CTSQ.value.length != 11 )
		{
			alert( "手机号长度必须为11" ) ;
			return false ;
		}

		document.form1.passWord.value = "000" + document.form1.feeType.value + document.form1.busiType.value ;
		//alert( "pass:" + document.form1.passWord.value + " feeType:" + document.form1.feeType.value + " busiType:" + document.form1.busiType.value);
	}
	if( biz_id == 9 )
	{		
		if( document.form1.CarNo.value.length != 5 )
		{
			alert( "车牌号码长度必须为5" ) ;
			return false ;
		}
	}	
	if( biz_id == 22 || biz_id == 23 || biz_id == 28)
	{		
		if( document.form1.CTSQ.value.length != 11 )
		{
			alert( "手机号长度必须为11" ) ;
			return false ;
		}
	}	
  if(clickBoolean)
  {
    form1.submit();
    clickBoolean = false;
  }
  //alert("33");
}
</script>

</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<center>
<div class="indent">
<table width="100%" align="center" cellpadding="1" cellspacing="1" class="tab">
  <tr align="left">    	   	
  	<td colspan="3" class="tab_title"><%=midObjectView.get_biz_memo().trim()%>（第二步）</td>
  </tr>

<FORM action="/personbank/HttpProxy" method=post name="form1">

<input type="hidden" name="Jflx" value="">
<input type="hidden" name="dse_sessionId" value="<%=dse_sessionId%>">
<%if( loginType.equals("0") ){%>
<input type="hidden" name="URL" value="/midserv/midServStep2.jsp">
<%}else{%>
<input type="hidden" name="URL" value="/midserv/midServStep3.jsp">
<%}%>
<input type="hidden" name="biz_id" value="<%=midObjectView.get_biz_id()%>">
<input type="hidden" name="biz_no" value="<%=midObjectView.get_biz_no().trim()%>">
<input type="hidden" name="step_id" value="<%=i_step_id+1%>">
<input type="hidden" name="stepCount" value="1">

<input type="hidden" name="CarType" value="A1">
<input type="hidden" name="DestAttr" value="0000">

<%if( i_biz_id != 7 ){%>
<input type="hidden" name="passWord">
<%}%>
<input type="hidden" name="feeType" value='1'>
<input type="hidden" name="busiType" value='01'>

<%ResultSet rs = midObjectStepView.getStepViewNotHidByBizIdAndStepId(i_biz_id,i_step_id);
	while (rs.next()) { %>
  <tr class="tab_tr">
     <td width="20%" align="center" height="22" class="InputTip"><%=rs.getString("input_lable").trim()%>：</td>
     <td width="30%" align="left" height="22" class="InputTip"><input type="<%=rs.getString("input_type").trim()%>" name="<%=rs.getString("input_name").trim()%>" size="<%=rs.getInt("input_size")%>" maxlength="<%=rs.getInt("input_size")%>" value="<%=rs.getString("input_value").trim()%>"></td>
  </tr> 
<%}
	if( i_biz_id == 7 )
	{
%>
		<tr class="tab_tr">
			<td width="20%" align="center" height="22" class="InputTip">移动服务密码：</td>
			<td width="20%" align="left" height="22" class="InputTip"><input type="password" name="passWord" size="11" maxlength="6"></td>
		</tr>	
<%
	}	
	if( i_biz_id == 8 )
	{
%>	
	  <tr class="tab_tr">
	  	<td width="30%" align="middle" height="22" class="InputTip">费用类型：</td>
	    <td width="70%" align="left" height="22" class="InputTip">
	      <input onClick="form1.feeType.value='1';" type="radio" name="radiobutton0" checked="true"> 预 付 费<br>
	      <input onClick="form1.feeType.value='0';" type="radio" name="radiobutton0"> 缴 欠 费<br>
	    </td>
		</tr>	     
		
	  <tr class="tab_tr">
	  	<td width="30%" align="middle" height="22" class="InputTip">业务类型：</td>
	    <td width="70%" align="left" height="22" class="InputTip">
	      <input onClick="form1.busiType.value='01';" type="radio" name="radiobutton1" checked="true" value="GSM">GSM(130/131)<br>
	      <input onClick="form1.busiType.value='03';" type="radio" name="radiobutton1" value="长途固话"> 长 途 固 话（/）<br>
	    </td>
		</tr>
<%			
	}
	if( i_biz_id == 9 )
	{
%>    		
	  <tr class="tab_tr">
	  	<td width="30%" align="middle" height="22" class="InputTip">车&nbsp;&nbsp;&nbsp;牌&nbsp;&nbsp;&nbsp;类&nbsp;&nbsp;&nbsp;型：</td>
	    <td width="15%" align="left" height="22" class="InputTip">
	      <input onClick="form1.CarType.value='A1';" type="radio" name="radiobutton2" checked="true" value="A1">大型汽车<br>
	      <input onClick="form1.CarType.value='A2';" type="radio" name="radiobutton2" value="A2">小型汽车<br>
	      <input onClick="form1.CarType.value='A5';" type="radio" name="radiobutton2" value="A5">挂车<br>
	    </td>
	    <td width="15%" align="left" height="22" class="InputTip">
	      <input onClick="form1.CarType.value='A6';" type="radio" name="radiobutton2" value="A6">拖拉机<br>
	      <input onClick="form1.CarType.value='A7';" type="radio" name="radiobutton2" value="A7">农用运输车<br>
	      <input onClick="form1.CarType.value='C1';" type="radio" name="radiobutton2" value="C1">外籍汽车<br>
	    </td>
		</tr>
		<tr class="tab_tr">
			<td width="20%" align="middle" height="22" class="InputTip">车牌号码（不含粤A）：</td>
			<td width="20%" align="left" height="22" class="InputTip"><input type="text" name="CarNo" size="5" maxlength="5"></td>
		</tr>	
		<tr class="tab_tr">
			<td width="20%" align="middle" height="22" class="InputTip">温&nbsp;&nbsp;&nbsp;馨&nbsp;&nbsp;&nbsp;提&nbsp;&nbsp;&nbsp;示：</td>
			<td width="20%" align="left" height="22" class="InputTip" colspan="2">仅适用广州市区（不含番禺、花都、南沙、从化、增城的车辆）</td>
		</tr>

<%
	}
	if( i_biz_id == 20 )
	{
%>	
	  <tr class="tab_tr">
	  	<td width="30%" align="middle" height="22" class="InputTip">费用类型：</td>
	    <td width="70%" align="left" height="22" class="InputTip">
	      <input onClick="form1.feeType.value='1';" type="radio" name="radiobutton0" checked="true"> 预 付 费<br>
	      <input onClick="form1.feeType.value='0';" type="radio" name="radiobutton0"> 缴 欠 费<br>
	    </td>
		</tr>
<%}
	if( i_biz_id == 26 )
	{
%>
		<tr class="tab_tr">
			<td width="30%" align="center" height="22" class="InputTip">被充值用户属性：</td>
			<td width="70%" align="left" height="22" class="InputTip">
	      <input onClick="form1.DestAttr.value='0000';" type="radio" name="radiobutton3" value="0000"> 固话<br>
	      <input onClick="form1.DestAttr.value='0001';" type="radio" name="radiobutton3" value="0001"> 小灵通<br>
	      <input onClick="form1.DestAttr.value='0002';" type="radio" name="radiobutton3" value="0002"> 移动号码<br>
	      <input onClick="form1.DestAttr.value='0003';" type="radio" name="radiobutton3" value="0003"> ADSL<br>
	      <input onClick="form1.DestAttr.value='0006';" type="radio" name="radiobutton3" value="0006"> 付费易账户<br>
	    </td>
		</tr>	
<%			
	}
	if(	i_biz_id == 30 )	
	{
%>	
	  <tr class="tab_tr">
	  	<td width="100%" align="middle" height="22" class="InputTip" colspan=2>业务类型</td>
	  </tr>
		<tr class="tab_tr">
		    <td width="100%" align="middle" height="22" class="InputTip">
		      <input onClick="form1.Jflx.value='01';" type="radio" name="radiobutton2" value="01">交费易－电信缴费<br>
		    </td>
	    </tr>
		<tr class="tab_tr">
		    <td width="100%" align="middle" height="22" class="InputTip">
		      <input onClick="form1.Jflx.value='02';" type="radio" name="radiobutton2" value="02">交费易－联通缴费<br>
		    </td>
		</tr>
		<tr class="tab_tr">
		    <td width="100%" align="middle" height="22" class="InputTip">
		      <input onClick="form1.Jflx.value='03';" type="radio" name="radiobutton2" value="03">交费易－移动缴费<br>
		    </td>
	    </tr>
		<tr class="tab_tr">
		    <td width="100%" align="middle" height="22" class="InputTip">
		      <input onClick="form1.Jflx.value='05';" type="radio" name="radiobutton2" value="05">交费易－车船税缴税<br>
		    </td>
		</tr>
<%			
	}				
	rs.close();
	midObjectStepView.releaseDBConnection();
%>
<tr class="tab_result">
	<td align="center" colspan="3">
		<input type="button" class="button_bg" onclick="javascript:beforeSubmit();" value="提交" style={cursor:hand;}>
		<%if(i_biz_id !=30 )
		{%>
		<input type="reset" class="button_bg" name="Submit2" value="重填">
		<%}%>
   <%if( i_biz_id == 1 ||i_biz_id == 2 || i_biz_id == 7 || i_biz_id == 8 || i_biz_id == 9 || i_biz_id ==22 || i_biz_id ==23 || i_biz_id ==26 || i_biz_id ==28 || i_biz_id ==30 )
	{%>
   <input type="button" class="button_bg" onclick="window.history.back();" value="返 回">
   <%}%>
	</td>
</tr>
</table>

<br>
<p>备注：<%=midObjectView.get_biz_detail().trim()%></p>
</FORM>

</DIV></CENTER></BODY></HTML>
