<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="dao" class="com.dao.BoardDAO" />
<jsp:useBean id="d" class="com.dao.BoardDTO" >
	<jsp:setProperty name="d" property="*" />
</jsp:useBean>
<%
	dao.boardInsert(d);
	response.sendRedirect("list.jsp");
%>