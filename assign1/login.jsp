<%@ page import ="java.sql.*" %>
<%
    String userid = request.getParameter("uname");    
    Class.forName("com.postgresql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/test",
            "postgres", "52362882");
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from members where uname='" + userid + "'"); <%username check%>
    if (rs.next()) {
        session.setAttribute("userid", userid);
        //out.println("welcome " + userid);
        //out.println("<a href='logout.jsp'>Log out</a>");
        response.sendRedirect("success.jsp");
    } else {
        out.println("Invalid password <a href='index.jsp'>try again</a>");
    }
%>