<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.gdbocom.util.PreAction" %>
<%@ page import="com.gdbocom.Transactions.WelLot" %>
<%@include file="/includeFiles/common.jsp" %>
<%
	int buyMode = Integer.parseInt(ReqParamUtil.reqParamTirm(request,"buyMode"));
	String action_next;
	
	if(buyMode==WelLot.HpTenBuy.ONE){
		//选一数投
		action_next="Wel_hTen_numSeleSingle.jsp";
		//action_next="/ToHtml";
	}else if(buyMode==WelLot.HpTenBuy.ONE_RED){
		//选一红投
		action_next="Wel_hTen_numSeleSingle.jsp";
		//action_next="/ToHtml?url=/WelLot/Wel_hTen_numSeleSingle.jsp";
	}else if(buyMode==WelLot.HpTenBuy.TWO){
		//任选二
		action_next="Wel_hTen_numSeleSingle.jsp";
	}else if(buyMode==WelLot.HpTenBuy.TWO_LINE){
		//选二连直
		action_next="Wel_hTen_numSeleMulti.jsp";
	}else if(buyMode==WelLot.HpTenBuy.TWO_GROUP){
		//选二连组
		action_next="Wel_hTen_numSeleSingle.jsp";
	}else if(buyMode==WelLot.HpTenBuy.THREE){
		//任选三
		action_next="Wel_hTen_numSeleSingle.jsp";
	}else if(buyMode==WelLot.HpTenBuy.THREE_LINE){
		//选三前直
		action_next="Wel_hTen_numSeleMulti.jsp";
	}else if(buyMode==WelLot.HpTenBuy.THREE_GROUP){
		//选三前组
		action_next="Wel_hTen_numSeleSingle.jsp";
	}else if(buyMode==WelLot.HpTenBuy.FOUR){
		//任选四
		action_next="Wel_hTen_numSeleSingle.jsp";
	}else if(buyMode==WelLot.HpTenBuy.FIVE){
		//任选五
		action_next="Wel_hTen_numSeleSingle.jsp";
	}else{
		action_next="Wel_hTen_numSeleSingle.jsp";
	}
	
	RequestDispatcher rd = request.getRequestDispatcher(action_next);
	rd.forward(request, response);
%>
