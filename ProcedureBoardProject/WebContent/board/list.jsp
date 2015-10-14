<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.dao.BoardDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="dao" class="com.dao.BoardDAO"/>
<%
	String strPage = request.getParameter("page");
	int curpage = (strPage == null) ? 1 : Integer.parseInt(strPage);
	List<BoardDTO> list = dao.boardListData(curpage);
	int totalpage = dao.boardTotalPage();
	int count = dao.boardRowCount();
	count = count - ((curpage*10-10));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="board.css"/>
</head>
<body>
  <h3 style="text-align: center">자유게시판</h3>
  	<div style="margin: 0 auto; width: 700px">
	<table>
      <tr> 
       <td align=left>
         <a href="insert.jsp">등록</a>
       </td>
      </tr>
    </table>
	<table>
		<tr style="background-color: #81D5DE; width: 700px">
			<th style="width: 10%">번호</th>
			<th style="width: 45%">제목</th>
			<th style="width: 15%">이름</th>
			<th style="width: 20%">작성일</th>
			<th style="width: 10%">조회수</th>
		</tr>
		<%
			for(BoardDTO d : list){
		%>		
			<tr>
				<th style="width: 10%"><%=count--%></th>
				<th style="width: 45%; text-align: left">
				<%
					if(d.getGroup_tab()>0){
						for(int i=0; i<d.getGroup_tab(); i++){
							out.println("&nbsp;&nbsp;");
						}
						out.println("<img src=\"../image/re_icon.gif\">");
					}
				%>
				<%
					String msg = "관리자에 의해 삭제된 게시물입니다";
					if(!msg.equals(d.getSubject())){
						
				%>
				<a href="content.jsp?no=<%=d.getNo()%>&page=<%=curpage%>&rn=<%=d.getRowNum()%>">
				<%=d.getSubject() %></a>
				<%
					} else {
						%>
						<span style="color: gray"><%=d.getSubject() %></span>
						<%
					}
				%>
				<%
					String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
					String dbday = d.getRegdate().toString();
					if(today.equals(dbday)){
						out.println("<sup><img src=\"../image/icon_new.png\"></sup>");
					}
				%>
				</th>
				<th style="width: 15%"><%=d.getName() %></th>
				<th style="width: 20%"><%=d.getRegdate()%></th>
				<th style="width: 10%"><%=d.getHit() %></th>
			</tr>	
		<%		
			}
		%>
	</table>
	</div>
	<hr style="width: 700px" />
	<table>
		<tr>
			<td>
			<%=curpage %> page / <%=totalpage %> pages
			</td>
		</tr>
	</table>
</body>
</html>