<%@ page import ="java.sql.*" %>
<%@page contentType="text/html; charset=GBK"%> 
<%@ page import="javax.naming.*"%> 
<%
    String user = request.getParameter("uname");    
    String age = request.getParameter("age");
    String name = request.getParameter("name");
    String address = request.getParameter("address");
    String email = request.getParameter("email");
	String role = request.getParameter("role");
	Boolean checkUnique;
	ResultSet rs;
    Class.forName("org.postgresql.Driver");
    Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/signup",
            "postgres", "8609126");
    Statement st = con.createStatement();
    //ResultSet rs;
    
    rs = st.executeQuery("SELECT * FROM account WHERE name = '" + name + "' ;");
    
    
    if( rs.next() ){
        response.sendRedirect("reg_failure.jsp");
    }
    else{
        int i = st.executeUpdate("insert into account(username, role, address, age, email, name) values ('" + user + "','" + role + "','" + address + "','" + age + "','" + email + "','" + name + "')");        
        
        if (i > 0) {
            //session.setAttribute("userid", user);
            response.sendRedirect("welcome.jsp");
            // out.print("Registration Successfull!"+"<a href='index.jsp'>Go to Login</a>");
        } else {
            response.sendRedirect("index.jsp");
        }
    }
%>