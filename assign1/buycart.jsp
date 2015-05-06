<%@ page import ="java.sql.*" %>
<%@ page import ="java.io.PrintWriter" %>
<%@ page import ="java.io.IOException" %>
<%@ page import ="javax.servlet.ServletException" %>
<%@ page import ="javax.servlet.http.HttpServlet" %>
<%@ page import ="javax.servlet.http.HttpServletRequest" %>
<%@ page import ="javax.servlet.http.HttpServletResponse" %>

<html>
<head>
<title> Buy Shopping Cart</title>
</head>
<%
String id = (String)session.getAttribute("userid");

if (id == null){
    out.print("<h3>You have not logged in</h3>");
    out.print("<p><a href='index.jsp'>click here to login in</a></p>");
}
else{
%>
<body>
<table>
<tr>
<td valign="top">
<%-- Import the java.sql package --%>
<%@ page import="java.sql.*"%>
<%-- -------- Open Connection Code -------- --%>
<%
Statement stmt;
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
ResultSet dropdownMenu = null;
String usid = (String)session.getAttribute("userid");
String pdid = request.getParameter("productid");
Integer total =0;
if(usid == null){
    out.print("<h3>You have not logged in</h3>");
}
else{
try {
                                                
    // Registering Postgresql JDBC driver with the DriverManager
    Class.forName("org.postgresql.Driver");
    
    // Open a connection to the database using DriverManager
    conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Assignment#1?" +
                                       "user=postgres&password=52362882");
    
    %>
    
    
    
    <!-- Add an HTML table header row to format the results -->
    
    <table border="1">
    <tr>
    <th>USER</th>
    <th>SKU</th>
    <th>Name</th>
    <th>Price</th>
    <th>Quantity</th>
    </tr>
    <%-- -------- SELECT Statement Code -------- --%>
    <%
    // Create the statement
    Statement statement = conn.createStatement();
    
    // Use the created statement to SELECT
    rs = statement.executeQuery("SELECT c.uid, c.pid, p.sku, c.price, c.quantity, p.name FROM cart c, products p WHERE c.uid='"+usid+"' and p.id =c.pid");

    %>
    <%-- -------- Iteration Code -------- --%>
    
    <%
    // Iterate over the ResultSet
    while (rs.next()) {
        total = total +rs.getInt("price")*rs.getInt("quantity");
        %>
        
        <tr>
        <form action="productorder.jsp" method="POST">
        <td>
        <%=rs.getString("uid")%>
        </td>
        <td>
        <%=rs.getString("sku")%>
        </td>
        <td>
        <%=rs.getString("name")%>
        </td>
        <td>
        $
        <%=rs.getInt("price")%>
        </td>
        <td>
        <%=rs.getInt("quantity")%>
        </td>
        <%-- Button --%>
        </form>
        </tr>
    
        <%}
        %>
    <%out.print("total price: $");%>
    <%out.print(total);%>
    <p><a href="bproducts.jsp?filter=-1&search=%3C%=request.getParameter%28">countinue shopping</a></p>
    <p><a href="purchase.jsp">Purchase</a></p>

    <%-- -------- Close Connection Code -------- --%>
    <%
    // Close the ResultSet
    rs.close();
    
    // Close the Statement
    statement.close();
    
    // Close the Connection
    conn.close();
} catch (SQLException e) {
    
    // Wrap the SQL exception in a runtime exception to propagate
    // it upwards
    
    throw new RuntimeException(e);
}
finally {
    // Release resources in a finally block in reverse-order of
    // their creation
    
    if (rs != null) {
        try {
            rs.close();
        } catch (SQLException e) { } // Ignore
        rs = null;
    }
    if (pstmt != null) {
        try {
            pstmt.close();
        } catch (SQLException e) { } // Ignore
        pstmt = null;
    }
    if (conn != null) {
        try {
            conn.close();
        } catch (SQLException e) { } // Ignore
        conn = null;
    }
    
}
}
%>
</table>
</td>
</tr>
</table>
</body>
<%
}
%>

</html>

