<%@page contentType="text/html; charset=GBK"%> 

<%@ page import="java.sql.*"%> 

<%@ page import="javax.naming.*"%> 

<html> 

<head> 

<meta http-equiv="Content-Type" content="text/html; charset=gb2312"> 

<title>Test of connection pool</title> 

</head> 

<body> 

<%  out.print("Start<br/>"); 

try{ 

InitialContext ctx = new InitialContext(); 

javax.sql.DataSource connectionPool = (javax.sql.DataSource) 

ctx.lookup("java:comp/env/mytest_ds"); 

Connection conn = connectionPool.getConnection(); 

out.print("DB connection pool run OK!"); 

conn.close(); 

} 

catch(Exception ex){ 

out.print(ex.getMessage()); 

ex.printStackTrace(); 

} 

%> 

</body> 

</html>