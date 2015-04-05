<%@ page import ="java.sql.*" %>
<%
    String user = request.getParameter("username");    
    String age = request.getParameter("age");
    String name = request.getParameter("name");
    String address = request.getParameter("address");
    String email = request.getParameter("email");
	String role = request.getParameter("role");
    Class.forName("com.postgresql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Assignment#1/account",
            "postgres", "52362882");
    Statement st = con.createStatement();
    //ResultSet rs;
    int i = st.executeUpdate("insert into members(username, role, email, address, age, name) values ('" + user + "','" + role + "','" + email + "','" + address + "','" + age + "','" + name + "')");
    if (i > 0) {
        //session.setAttribute("userid", user);
        response.sendRedirect("welcome.jsp");
       // out.print("Registration Successfull!"+"<a href='index.jsp'>Go to Login</a>");
    } else {
        response.sendRedirect("index.jsp");
    }
%>