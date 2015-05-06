<%@ page import ="java.io.PrintWriter" %>
<%@ page import ="java.io.IOException" %>
<%@ page import ="javax.servlet.ServletException" %>
<%@ page import ="javax.servlet.http.HttpServlet" %>
<%@ page import ="javax.servlet.http.HttpServletRequest" %>
<%@ page import ="javax.servlet.http.HttpServletResponse" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
String id = (String)session.getAttribute("userid");

if (id == null){
    out.print("<h3>You have not logged in</h3>");
    out.print("<p><a href='index.jsp'>click here to login in</a></p>");
}
else{
%>
<%
// simple form date convert date> string
SimpleDateFormat dateFormatWithTime = new SimpleDateFormat("MM/dd/yyyy hh:mm");
String s = dateFormatWithTime.format(new java.util.Date());
out.print(s);
%>

<html>
<head>
<title> Purchase</title>
</head>
<body>
<table>
<tr>
<td valign="top">
<%-- Import the java.sql package --%>
<%@ page import="java.sql.*"%>

<%-- -------- Open Connection Code -------- --%>
<%
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
String usid = (String)session.getAttribute("userid");
Integer total = 0;


try {
    
    // Registering Postgresql JDBC driver with the DriverManager
    Class.forName("org.postgresql.Driver");
    
    // Open a connection to the database using DriverManager
    conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Assignment#1?" +
                                       "user=postgres&password=52362882");
    
    %>
    
    
    
    <!-- Add an HTML table header row to format the results -->
    
    <form method="post" action="confirm.jsp">
    <td><input type="hidden" name="action" value="purchase" /></td>
    <td><input type="hidden" name="date" value=<%=dateFormatWithTime.format(new java.util.Date())%> /></td>

    <center>
    <table border="1" width="30%" cellpadding="5">
    <thead>
    <tr>
    <th colspan="2">Enter Purchase Information Here</th>
    </tr>
    </thead>
    <tbody>
    <tr>
    <td>CreditCard# </td>
    <td><input type="text" name="cdd" value="" /></td>
    </tr>
    <tr>
    <td>name</td>
    <td><input type="text" name="name" value="" /></td>
    </tr>
    <tr>
    <td><input type="submit" value="Purchase" /></td>
    <td><input type="reset" value="Reset" /></td>
    </tr>
    </tbody>
    </table>
    </center>
    </form>
    <%-- -------- SELECT Statement Code -------- --%>
    <%
    // Create the statement
    // Use the created statement to SELECT
    Statement statement = conn.createStatement();
    rs = statement.executeQuery("SELECT c.uid, c.pid, p.sku, c.price, c.quantity, p.name FROM cart c, products p WHERE c.uid='"+usid+"' and p.id =c.pid");    
    %>
    <%-- -------- Iteration Code -------- --%>
    
    <table border="1">
    <tr>
    <th>USER</th>
    <th>SKU</th>
    <th>Name</th>
    <th>Price</th>
    <th>Quantity</th>
    </tr>

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
    <%
    // Iterate over the ResultSet
    while (rs.next()) {
        total =total + rs.getInt("price")*rs.getInt("quantity");
        String userid=rs.getString("uid");
        String sku=rs.getString("pid");
        Integer price=rs.getInt("price");
        Integer quantity=rs.getInt("quantity");
        
        }
    %>
    <p>
    <%out.print("total price: $");%>
    <%out.print(total);%>
    </p>
    <p><a href="bproducts.jsp?filter=-1&search=%3C%=request.getParameter%28">countinue shopping</a></p>
    
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
%>
</table>
</td>
</tr>
</table>
</body>

</html>
<%
}
%>

