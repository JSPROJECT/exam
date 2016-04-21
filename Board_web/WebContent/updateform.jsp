<%@page import="kosta.model.Board"%>
<%@page import="kosta.model.BoardService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String id = request.getParameter("b_id");
	int b_id = 0;
	if(id !=null){
		b_id = Integer.parseInt(id);
	}
	
	BoardService service = BoardService.getInstance();
	Board board =  service.updatebeforeService(b_id);
	
	request.setAttribute("board", board);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h4>글 세부보기</h4>
	<form action="updateOk.jsp" method="post">
	<input type="hidden" name="b_id" value="${board.b_id }" />
	<table border="1">
		<tr height="30">
			<td width="150">작성자</td>
			<td width="150"><input type="text" name="b_name" value="${board.b_name }" /></td>
			<td width="150">작성일</td>
			<td width="150"><fmt:formatDate value="${board.b_date }" pattern="yyyy-MM-dd"/></td>
		</tr>
		<tr height="30">
			<td width="150">제목</td>
			<td colspan="3"><input type="text" name="b_title" value="${board.b_title }" /></td>
		</tr>
		<tr height="30">
			<td width="150">내용</td>
			<td colspan="3"><input type="text" name="b_content" value="${board.b_content }" /></td>
		</tr>
		<tr>
			<td width="150">비밀번호</td>
			<td colspan="3"><input type="text" name="b_pwd" /></td>
		</tr>
	</table>
		<button type="submit">수정</button>
	</form>
</body>
</html>