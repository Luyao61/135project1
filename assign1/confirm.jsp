<%@ page import ="java.sql.*" %>
<%@ page import ="java.io.PrintWriter" %>
<%@ page import ="java.io.IOException" %>
<%@ page import ="javax.servlet.ServletException" %>
<%@ page import ="javax.servlet.http.HttpServlet" %>
<%@ page import ="javax.servlet.http.HttpServletRequest" %>
<%@ page import ="javax.servlet.http.HttpServletResponse" %>
<%@ page import="java.util.*" %>
<html>

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
    conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/project1?" +
                                       "user=postgres&password=52362882");
    
    // select
    Statement stmt = conn.createStatement();
    rs = stmt.executeQuery("SELECT * FROM cart WHERE uid='"+usid+"'");
    //add to cart
    
    String paction = request.getParameter("action");
    // Check if an insertion is requested
    if (paction != null && paction.equals("confirm")) {
        while (rs.next()) {
            Integer id=rs.getInt("id");
            String userid=rs.getString("uid");
            String sku=rs.getString("pid");
            Integer price=rs.getInt("price");
            Integer quanity=rs.getInt("quanity");
        //---- ---- --- add to bought cart---- ------
        // Begin transaction
        conn.setAutoCommit(false);
        
        // Create the prepared statement and use it to
        // INSERT name description INTO the products table.
        pstmt = conn
        .prepareStatement("INSERT INTO boughtcart (uid, pid, price, quanity, date) VALUES (?, ?, ?, ?, ?)");
        pstmt.setString(1, userid);
        pstmt.setString(2, sku);
        pstmt.setInt(3, price);
        pstmt.setInt(4, quanity);
        pstmt.setString(5,request.getParameter("date"));

        pstmt.executeUpdate();
        
        // Commit transaction
        conn.commit();
        conn.setAutoCommit(true);
    //---- ---- --- Delete from shopping cart---- ------
        conn.setAutoCommit(false);
            
            // Create the prepared statement and use it to
            // INSERT name description INTO the products table.
        pstmt = conn
        .prepareStatement("DELETE FROM cart WHERE id ='"+id+"'");
            
        pstmt.executeUpdate();
            
        // Commit transaction
        conn.commit();
        conn.setAutoCommit(true);

        }
    }
    %>
    
    
    <!-- Add an HTML table header row to format the results -->
    <p>
    Payment Confirmation !!!!!
    </p>
    <form method="post" action="confirm.jsp">
    <td><input type="hidden" name="action" value="confirm" /></td>
    <td><input type="hidden" name="date" value= <%=request.getParameter("date")%> /></td>
    <td><input type="hidden" name="name" value= <%=request.getParameter("name")%> /></td>
    <td><input type="submit" value="Confirm payment" size= 100/></td>
    </form>
    
    <%-- -------- SELECT Statement Code -------- --%>
    <%
    // Create the statement
    
    // Use the created statement to SELECT
    // the student attributes FROM the categories table.
    Statement statement = conn.createStatement();
    rs = statement.executeQuery("SELECT * FROM cart WHERE uid='"+usid+"'");
    
    %>
    <%-- -------- Iteration Code -------- --%>
    <%=request.getParameter("date")%>
    <table border="1">
    <tr>
    <th>USER</th>
    <th>SKU</th>
    <th>price</th>
    <th>quanity</th>
    </tr>
    <%
    // Iterate over the ResultSet
    while (rs.next()) {
        total = total +rs.getInt("price")*rs.getInt("quanity");
        %>
        
        <tr>
        <form action="productorder.jsp" method="POST">
        <td>
        <%=rs.getString("uid")%>
        </td>
        <td>
        <%=rs.getString("pid")%>
        </td>
        <td>
        <%=rs.getInt("price")%>
        </td>
        <td>
        <%=rs.getInt("quanity")%>
        </td>
        <%-- Button --%>
        </form>
        </tr>
        
        <%}
        %>
    <p>
    <%out.print("total price:");%>
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

