<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>HOME</title>
</head>
<body>
    <%
    //out.print("<h1>HELLO</h1>");
    //out.print(session.getAttribute("userType"));
    //out.print(session.getAttribute("userType").getClass().getName());

    String owner = new String("Owner");
    String customer = new String("Customer");
    String role = (String)session.getAttribute("userType");
    String userid = request.getParameter("nuserid");



    if (session.getAttribute("userType") == null) {
        out.print("<p>Invalid password <a href='index.jsp'>try again</a></p>");
    } 
    //if(session.getAttribute("userType") == customer ) {
    else if( role.contains("Customer") ) {
    %>
        <h3>You have Successfully logged in.</h3>
        <h3>Welcome <%=session.getAttribute("userid")%> </h3>
        <p>Links:<a href="bproducts.jsp">products</a></p>
        <p>Click <a href='logout.jsp'>here</a> to logout.</p>

    <%
    } 
    else if( role.contains("Owner") ) {
    %>
        <h3>You have Successfully logged in.</h3>
        <h3>Welcome <%=session.getAttribute("userid")%> </h3>
        <p>Links:<a href="categories.jsp">categories</a></p>
        <p>Links:<a href="products.jsp">products</a></p>
        <p>Click <a href='logout.jsp'>here</a> to logout.</p>

    <%
    }
    //out.print("<h1>NO</h1>");
    %>
    

    
</body>
</html>
