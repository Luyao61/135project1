<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Login success</title>
</head>
<body>
    <h3>You have Successfully logged in.</h3>
    <h3>Welcome <%=session.getAttribute("userid")%> </h3>
    <p>Click <a href='logout.jsp'>here</a> to logout.</p>
</body>
</html>

<!--
<%
    if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
%>
You are not logged in<br/>
<a href="index.jsp">Please Login</a>
<%} else {
%>
Welcome <%=session.getAttribute("userid")%>
<a href='logout.jsp'>Log out</a>
<%
    }
%>
-->