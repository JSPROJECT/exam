<%@page import="kosta.model.BoardService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String r_id = request.getParameter("r_id");
	BoardService service = BoardService.getInstance();
	int re = service.deleteReply(r_id);
	if(re >0){
		response.sendRedirect("");
	}else{
		response.sendRedirect("");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>