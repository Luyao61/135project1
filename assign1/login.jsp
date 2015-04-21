<%@ page import ="java.sql.*" %>
<%@page contentType="text/html; charset=GBK"%> 
<%@ page import="javax.naming.*"%> 
<%
    String userid = request.getParameter("name");    
    Class.forName("org.postgresql.Driver");
Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Assignment#1",
            "postgres", "52362882");
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from account where name='" + userid + "'"); 
    if (rs.next()) {
    
        String usrType = rs.getString("role");
        session.setAttribute("userid", userid);
        session.setAttribute("userType", usrType);

        response.sendRedirect("home.jsp");
    } else {
        out.println("Invalid password <a href='index.jsp'>try again</a>");
    }
%>