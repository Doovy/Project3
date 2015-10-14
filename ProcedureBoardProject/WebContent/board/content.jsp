<%@page import="com.dao.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="dao" class="com.dao.BoardDAO" />
<%
	String strNo = request.getParameter("no");
	String strPage = request.getParameter("page");
	String strRn = request.getParameter("rn");
	// DB연동
	BoardDTO d = dao.boardContentData(Integer.parseInt(strNo));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="board.css"/>
<style type="text/css">
	table {
		margin: 0 auto;
		width: 500px;
	}
	h3 {
		text-align: center;
	}
</style>
</head>
<body>
     <h3>내용보기</h3>
     <table border=1 cellpadding="0" cellspacing="0">
       <tr height=27>
        <td width=20% align=center bgcolor=#ccccff>번호</td>
        <td width=30% align=center><%=d.getNo() %></td>
        <td width=20% align=center bgcolor=#ccccff>작성일</td>
        <td width=30% align=center><%=d.getRegdate().toString() %></td>
       </tr>
       <tr height=27>
        <td width=20% align=center bgcolor=#ccccff>이름</td>
        <td width=30% align=center><%=d.getName() %></td>
        <td width=20% align=center bgcolor=#ccccff>조회수</td>
        <td width=30% align=center><%=d.getHit() %></td>
       </tr>
       <tr height=27>
        <td width=20% align=center bgcolor=#ccccff>제목</td>
        <td colspan="3" align=left><%=d.getSubject() %></td>
       </tr>
       <tr>
         <td align=left valign="top" height=200
          colspan="4">
          <%=d.getContent() %>
         </td>
       </tr>
      
     </table>
     <table border=0 style="width=500px;">
       <tr>
         <td align=right>
           <a href="update.jsp?no=<%=strNo%>&page=<%=strPage%>">수정</a>&nbsp;
           <a href="delete.jsp?no=<%=strNo%>&page=<%=strPage%>">삭제</a>&nbsp;
           <a href="list.jsp?page=<%=strPage%>">목록</a>
         </td>
       </tr>
     </table>
</body>
</html>