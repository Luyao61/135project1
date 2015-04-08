<%@ page import ="java.sql.*" %>
<%@page contentType="text/html; charset=GBK"%> 
<%@ page import="javax.naming.*"%> 
<%
    String userid = request.getParameter("uname");    
    Class.forName("org.postgresql.Driver");
    Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/signup",
            "postgres", "8609126");
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from account where username='" + userid + "'"); 
    if (rs.next()) {
        session.setAttribute("userid", userid);
        //out.println("welcome " + userid);
        //out.println("<a href='logout.jsp'>Log out</a>");
        response.sendRedirect("success.jsp");
    } else {
        out.println("Invalid password <a href='index.jsp'>try again</a>");
    }
%>