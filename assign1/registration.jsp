<%@ page import ="java.sql.*" %>
<%@page contentType="text/html; charset=GBK"%> 
<%@ page import="javax.naming.*"%> 
<%
    String age = request.getParameter("age");
    String name = request.getParameter("name");
	String role = request.getParameter("role");
	String state = request.getParameter("state");
	Boolean checkUnique;
	ResultSet rs;
    
    try{
    
        Class.forName("org.postgresql.Driver");
        Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/project1",
            "postgres", "52362882");
        Statement st = con.createStatement();
        rs = st.executeQuery("SELECT * FROM account WHERE name = '" + name + "' ;");
        if( rs.next() ){
            response.sendRedirect("reg_failure.html");
        }
        else{
            int i = st.executeUpdate("INSERT INTO account(name, role, age, state) values ('" + name + "','" + role + "','" + age + "','"+ state + "');");        
        
            if (i > 0) {
                //session.setAttribute("userid", user);
                response.sendRedirect("welcome.jsp");
                // out.print("Registration Successfull!"+"<a href='index.jsp'>Go to Login</a>");
            } else {
                response.sendRedirect("index.jsp");
            }
        }   
    }
    catch(SQLException e){
        //System.out.println(e.printStackTrace());
        response.sendRedirect("reg_failure.jsp");
    }
%>