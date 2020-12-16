<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.ArrayList"%>
<%@page import="controller.ZipcodeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 파일명 : 08GugunOption.jsp --%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
request.setCharacterEncoding("UTF-8");

String sido = request.getParameter("sido");
ZipcodeDAO dao = new ZipcodeDAO();
ArrayList<String> gugunList = dao.getGugun(sido);

JSONArray jsonArr = new JSONArray();

for(String gu : gugunList){
	jsonArr.add(gu);
}

out.println(jsonArr.toString());
%>
