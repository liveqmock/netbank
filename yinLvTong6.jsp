<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ page import="com.bocom.midserv.gz.*,com.bocom.eb.des.*"%>
<%@ page import="com.viatt.bean.*"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%
	GzLog log = new GzLog("c:/gzLog");
	String loginType = request.getParameter("loginType");//���͵�½��� 0��ע���û�(�ֻ���) 1��֤���û� 2�������û�
	String dse_sessionId = MessManTool.changeChar(request.getParameter("dse_sessionId"));//��ȡdse_sessionId
	String cdno = MessManTool.changeChar(request.getParameter("cardNo"));
	String step_id = MessManTool.changeChar(request.getParameter("step_id"));
	String password = MessManTool.changeChar(request.getParameter("password"));//��������
	if(password.equals("")){
		System.out.println("��������Ϊ��");
			AppParam.setParam(dse_sessionId+"midErr1","��������");
			AppParam.setParam(dse_sessionId+"midErr2","��������Ϊ��");
%>
<script type="text/javascript">
	window.location="/personbank/HttpProxy?URL=/midserv/midservError.jsp&dse_sessionId=<%=dse_sessionId%>";
</script>
<%
		return;
	}
//	if(password != null)
//	{
//		password = EBDES.decryptoDES(password, dse_sessionId);//���ܺ�����
//	}
	String biz_id = MessManTool.changeChar(request.getParameter("biz_id"));
	if (biz_id.equals("")) {
		System.out.println("�����������ȷ");
	}
	if(loginType.equals("0")){
		String dynamicCode1=AppParam.getParam(dse_sessionId);
		String dynamicCode=MessManTool.changeChar(request.getParameter("dynamicCode"));
		if(!dynamicCode.equals(dynamicCode1)){
			System.out.println("��̬���벻��");
			AppParam.setParam(dse_sessionId+"midErr1","��������");
			AppParam.setParam(dse_sessionId+"midErr2","��̬���벻��");
%>
<script type="text/javascript">
	window.location="/personbank/HttpProxy?URL=/midserv/midservError.jsp&dse_sessionId=<%=dse_sessionId%>";
</script>
<%
		return;
		}
	}
	String content = "bocom_mid|biz_id,21|biz_step_id,5"+
	"|Product_Code,"+MessManTool.changeChar(request.getParameter("ticketCode"))+//��Ʊ����
	"|Retail_Price1,"+MessManTool.changeChar(request.getParameter("mpj"))+//���м�
	"|E_Discount_Price1,"+MessManTool.changeChar(request.getParameter("dzyhj"))+//�����Żݼ�
	"|Reserve_Amoun,"+MessManTool.changeChar(request.getParameter("gmzs"))+//��������
	"|Mobile_Phone_Number,"+MessManTool.changeChar(request.getParameter("sjhm1"))+//�ֻ���
	"|Begin_Date,"+MessManTool.changeChar(request.getParameter("mprq"))+//��Ʊ����
	"|Message_Type,"+MessManTool.changeChar(request.getParameter("sjlx"))+//�ֻ�����
	"|Amount1,"+MessManTool.changeChar(request.getParameter("zjr"))+//�ܽ��
	"|CDNO,"+cdno+//����
	"|PSWD,"+password+//��������
	"|Scence_Code,"+MessManTool.changeChar(request.getParameter("sightCode"))+//��������
	"|Scence_Name,"+MessManTool.changeChar(request.getParameter("sightName"))+//��������
	"|Product_Name,"+MessManTool.changeChar(request.getParameter("mpms"))+//��Ʊ����
	"|Remark1,"+MessManTool.changeChar(request.getParameter("bz"))+//��ע
	"|Valid_Days,"+MessManTool.changeChar(request.getParameter("yxrq"))+"|TXNSRC,WE441|";//��Ч����
	
	System.out.println("wy:"+content);
	MidServer midServer = new MidServer();
	BwResult bwResult = midServer.sendMessage(content);
	
	if (bwResult == null || bwResult.getCode() == null
			|| !bwResult.getCode().equals("000")) {
			System.out.println("���׽������");
			AppParam.setParam(dse_sessionId+"midErr1","ʧ��");
			AppParam.setParam(dse_sessionId+"midErr2",bwResult.getContext());
%>
<script type="text/javascript">
	window.location="/personbank/HttpProxy?URL=/midserv/midservError.jsp&dse_sessionId=<%=dse_sessionId%>";
</script>
<%
	return;
	}
	String tmp = bwResult.getContext();
	String info=MessManTool.getValueByName(tmp,"MGID");
	if(info==null||info.equals("")||!info.equals("000000")){
		System.out.println("���ײ��ɹ�");
			AppParam.setParam(dse_sessionId+"midErr1","ʧ��");
			AppParam.setParam(dse_sessionId+"midErr2","���ײ��ɹ���");
%>
<script type="text/javascript">
	window.location="/personbank/HttpProxy?URL=/midserv/midservError.jsp&dse_sessionId=<%=dse_sessionId%>";
</script>
<%
	return;
	}
%>

<!-------------------------------------------------------------------
                          ��׼JavaScript������
--------------------------------------------------------------------->
<script language="JavaScript" src="/personbank/HttpProxy?URL=/midserv/js/public.js&dse_sessionId=<%=dse_sessionId%>"></script>
<script language="JavaScript" src="/personbank/HttpProxy?URL=/midserv/js/common.js&dse_sessionId=<%=dse_sessionId%>"></script>

<!--------------------------------------------------------------------
   ��ǰҳ��JavaScript�������֣������ύ��֤��ҳ�涯��������Ŀ��ȴ���
---------------------------------------------------------------------->

<!--------------------------------------------------------------------
                          ҳ��HTML���ֲ���    
---------------------------------------------------------------------->

<html>
	<title>��ͨ�������Ϸ���</title>
	<head>
		<link rel="stylesheet"
			href="/personbank/HttpProxy?URL=/midserv/css/personbank.css&dse_sessionId=<%=dse_sessionId%>">
		<link rel="stylesheet"
			href="/personbank/HttpProxy?URL=/midserv/css/midserv.css&dse_sessionId=<%=dse_sessionId%>">
		<link href="/personbank/css/csspt.css" rel="stylesheet"
			type="text/css">
		<link href="/personbank/css/content.css" rel="stylesheet" type="text/css">
	</head>

	<body leftmargin="0" topmargin="0" oncontextmenu=self.event.returnValue=false onselectstart="return false">
		<center>
			<DIV align=center>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td
							background="/personbank/HttpProxy?URL=/midserv/images/pageTitle.gif&dse_sessionId=<%=dse_sessionId%>"
							class="pageTitle">
							&nbsp;&nbsp;Ԥ �� �� �� ���� Ʊ �� Ϣ �� �£�
						</td>
						<td rowspan="2" align="right" valign="top">
							&nbsp;
						</td>
					</tr>
					<tr>
						<td>
							<img
								src="/personbank/HttpProxy?URL=/midserv/images/xianb.gif&dse_sessionId=<%=dse_sessionId%>"
								width="100" height="20">
						</td>
					</tr>
				</table>
				<FORM action="/personbank/HttpProxy" method=post name="f1">
					<input type="hidden" name="dse_sessionId"
						value="<%=dse_sessionId%>">
					<input type="hidden" name="URL" value="/midserv/midSelect.jsp">
					<table border="0" cellspacing="2" cellpadding="0" align="center"
						width="86%">
						<tr>
							<td align="right" height="22" class="InputTip">
								��������:
							</td>
							<td align="left" height="22" class="InputTip">
								<%=MessManTool.changeChar(request.getParameter("sightName")) %>
							</td>
						</tr>
						<tr>
							<td align="right" height="22" class="InputTip">
								��Ʊ����:
							</td>
							<td align="left" height="22" class="InputTip">
								<%=MessManTool.changeChar(request.getParameter("mpms")) %>
							</td>
						</tr>
						<tr>
							<td align="right" height="22" class="InputTip">
								��������:
							</td>
							<td align="left" height="22" class="InputTip">
								<%=MessManTool.getValueByName(tmp, "TCUSNM") %>
							</td>
						</tr>
						<tr>
							<td align="right" height="22" class="InputTip">
								�����ˮ��:
							</td>
							<td align="left" height="22" class="InputTip">
								<%=MessManTool.getValueByName(tmp, "TckNo") %>
							</td>
						</tr>
						<tr>
							<td align="right" height="22" class="InputTip">
								�ͻ��ֻ�����:
							</td>
							<td align="left" height="22" class="InputTip">
								<%=MessManTool.changeChar(request.getParameter("sjhm1")) %>
							</td>
						</tr>
						<tr>
							<td align="right" height="22" class="InputTip">
								�����Żݼ۸�:
							</td>
							<td align="left" height="22" class="InputTip">
								<%=MessManTool.changeChar(request.getParameter("dzyhj")) %>
							</td>
						</tr>
						<tr>
							<td align="right" height="22" class="InputTip">
								��Ʊ����:
							</td>
							<td align="left" height="22" class="InputTip">
								<%=MessManTool.changeChar(request.getParameter("gmzs")) %>
							</td>
						</tr>
						<tr>
							<td align="right" height="22" class="InputTip">
								����֧�����:
							</td>
							<td align="left" height="22" class="InputTip">
								<%=MessManTool.changeChar(request.getParameter("zjr")) %>
							</td>
						</tr>
						<tr>
							<td align="right" height="22" class="InputTip">
								ʹ������:
							</td>
							<td align="left" height="22" class="InputTip">
								<%=MessManTool.changeChar(request.getParameter("mprq")) %>
							</td>
						</tr>
						<tr>
							<td align="right" height="22" class="InputTip">
								��Ʊ��Ч����:
							</td>
							<td align="left" height="22" class="InputTip">
								<%=MessManTool.changeChar(request.getParameter("yxrq")) %>
							</td>
						</tr>
						<tr>
							<td align="right" height="22" class="InputTip">
								��ע:
							</td>
							<td align="left" height="22" class="InputTip">
								<%=MessManTool.changeChar(request.getParameter("bz")) %>
							</td>
						</tr>
					</table>
					<table width="80%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
							<b>��ܰ��ʾ��</b>
						</td>
					</tr>
					<tr>
						<td>
								����ʹ������֮�����Ч������ʹ�ã�������ڣ��ھ�����Ʊ����ʾ��Ʊ���п����յ��ֻ���ά�����ȡƱ������ͨ�ͻ���������4008-960-168
						</td>
					</tr>
				</table>
				</FORM>
				<table>
					<tr>
						<td>
							<input onchange="" type="button" onclick="tj();" value="�� ��" class="button_bg">
						</td>
					</tr>
				</table>
			</DIV>
		</center>
	</body>
</html>