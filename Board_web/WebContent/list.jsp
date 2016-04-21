<%@page import="kosta.model.ListModel"%>
<%@page import="kosta.model.Board"%>
<%@page import="kosta.model.Reply"%>
<%@page import="java.util.List"%>
<%@page import="kosta.model.BoardService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%

	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	request.setAttribute("pageNum", pageNum);
	int requestPage = Integer.parseInt(pageNum);
 
	BoardService service = BoardService.getInstance();
	ListModel listModel = service.listBoardService(requestPage,request);
	request.setAttribute("listModel", listModel);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>글목록보기</h3>
	<a href="insertform.jsp">글쓰기</a>
	<table border="1" cellspacing="0" cellpadding="0">
		<tr height="30">
			<th width="50">번호</th>
			<th width="100">이미지</th>
			<th width="250">제목</th>
			<th width="150">작성자</th>
			<th width="150">작성일</th>
			<th width="100">조회수</th>
		</tr>
		<c:forEach var="board" items="${listModel.list }">
			<tr height="30">
				<td align="center">${board.b_id }</td>
				<td align="center">
				<c:if test="${board.b_fname!=null }">
					<c:set var="head" value="${fn:substring(board.b_fname,0,fn:length(board.b_fname)-4)}"></c:set>
				<c:set var="pattern" value="${fn:substringAfter(board.b_fname,head) }"></c:set>
				<img alt="이미지" src="upload/${head }_small${pattern}" />
				</c:if></td>
				<td align="left"><c:if test="${board.b_level>0 }"><c:forEach begin="0" end="${board.b_level }">&nbsp;&nbsp;</c:forEach><img alt="이미지" src="images/AnswerLine.gif"></c:if>
				<a href="detail.jsp?b_id=${board.b_id}">${board.b_title }</a></td>
				<td align="center">${board.b_name }</td>
				<td align="center"><fmt:formatDate value="${board.b_date }" pattern="yyyy-MM-dd"/></td>
				<td align="center">${board.b_hit }</td>
			</tr>
		</c:forEach>
	</table>
	<br />
	<br />
	<!-- 페이징 처리 -->
	<!-- 현재페이지, 페이지당 글갯수, 총글갯수, 페이지갯수,시작페이지, 마지막페이지 -->
	
	<c:if test="${listModel.startPage >5 }">
		<a href="list.jsp?pageNum=${listModel.startPage-5}">[이전]</a>
	</c:if>
	<c:forEach var="pageNo" begin="${listModel.startPage }" end="${listModel.endPage }">
		<c:if test="${listModel.requestPage == pageNo }"><b></c:if>
				<a href="list.jsp?pageNum=${pageNo}">[${ pageNo}]</a>
		<c:if test="${listModel.requestPage == pageNo }"></b></c:if>
	</c:forEach>
	<c:if test="${listModel.endPage < listModel.totalPageCount}">
		<a href="list.jsp?pageNum=${listModel.startPage+5}">[이후]</a>
	</c:if>
	<br />
	<br />
	<center>
	<form action="list.jsp">
		<input type="checkbox" name="area" value="b_title">제목</input>
		<input type="checkbox" name="area" value="b_name">작성자</input>
		<input type="text" name="searchKey" size="10"></input>
		<input type="hidden" name="temp" value="temp"></input>
		<input type="submit"  value="검색" />
	</form>
	</center>
</body>
</html>