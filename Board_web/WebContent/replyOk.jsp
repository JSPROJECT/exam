<%@page import="kosta.model.Reply"%>
<%@page import="kosta.model.BoardService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%
	String b = request.getParameter("r_name");
	String c =request.getParameter("r_content");
	int d = Integer.parseInt(request.getParameter("b_id"));
	
	System.out.println(b);
	System.out.println(c);
	System.out.println(d);
	 
	Reply reply = new Reply();
	
	reply.setR_name(b);
	reply.setR_content(c);
	reply.setB_id(d);
	
	BoardService service = BoardService.getInstance();
	int re = service.insertReply(reply);
	if(re > 0)
	{
	  response.sendRedirect("detail.jsp?b_id="+d);
	}
	else
	{
	  response.sendRedirect("detail.jsp?b_id="+d);
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