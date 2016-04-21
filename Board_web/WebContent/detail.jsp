<%@page import="java.util.List"%>
<%@page import="kosta.model.Reply"%>
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
	Board board =  service.selectBoardService(b_id);
	
	List<Reply> list = service.listreply(b_id);
	
	request.setAttribute("list", list);
	request.setAttribute("board", board);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function fn_reply(){
		location.href = "insertform.jsp?b_id=${board.b_id}";
	}
	function fn_update(){
		location.href ="updateform.jsp?b_id=${board.b_id }";
	}
	function gogo(r_id){
		location.href="replyDelete.jsp?r_id="+r_id;
	}
</script>
</head>
<body>
	<h4>글 세부보기</h4>
	<table border="1">
		<tr height="30">
			<td width="150">글번호</td>
			<td width="150">${board.b_id }</td>
			<td width="150">조회수</td>
			<td width="150">${board.b_hit }</td>
		</tr>
		<tr height="30">
			<td width="150">작성자</td>
			<td width="150">${board.b_name }</td>
			<td width="150">작성일</td>
			<td width="150"><fmt:formatDate value="${board.b_date }" pattern="yyyy-MM-dd"/></td>
		</tr>
		<tr height="30">
			<td width="150">파일</td>
			<td colspan="3"><a href="download.jsp?filename=${board.b_fname }">${board.b_fname }</a></td>
		</tr>
		<tr height="30">
			<td width="150">제목</td>
			<td colspan="3">${board.b_title }</td>
		</tr>
		<tr height="30">
			<td colspan="4">${board.b_content }</td>
		</tr>
		<tr height="30">
			<td colspan="4">
				<input type="button" value="답변글" onclick="fn_reply()" />&nbsp;
				<input type="button" value="수정" onclick="fn_update()" />
			</td>
		</tr>
	</table>
	<table border="1">
	<c:forEach var="reply" items="${list}">
		<tr height="30">
			<th width="100">작성자</th><td width="150">${reply.r_name}</td>
			<th width="100">글내용</th><td width="250">${reply.r_content}</td>
			<td><input type="button" value="삭제" onclick="javascript:gogo(${reply.r_id})"/>
		</tr>
	</c:forEach>
	</table>
	<form action="replyOk.jsp" method="post">
		<input type="hidden" name="b_id" value="${board.b_id }" />
		<table>
			<tr>
				<th>작성자</th><td><input type="text" name="r_name" /></td>
				<th>댓글내용</th><td><input type="text" name="r_content" /></td>
				<td><input type="submit" value="전송" /></td>
			</tr>
		</table>
	</form>
</body>
</html>