<%@ page import ="java.sql.*" %>
<%@ page import ="java.io.PrintWriter" %>
<%@ page import ="java.io.IOException" %>
<%@ page import ="javax.servlet.ServletException" %>
<%@ page import ="javax.servlet.http.HttpServlet" %>
<%@ page import ="javax.servlet.http.HttpServletRequest" %>
<%@ page import ="javax.servlet.http.HttpServletResponse" %>

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
ResultSet dropdownMenu = null;
String uid = (String)session.getAttribute("userid");
String pid = request.getParameter("productid");
Int price = Integer.parseInt(request.getParameter("price"))
try {
    // Registering Postgresql JDBC driver with the DriverManager
    Class.forName("org.postgresql.Driver");
    
    // Open a connection to the database using DriverManager
    conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Assignment#1?" +
                                       "user=postgres&password=52362882");
    %>
    <%-- -------- addtocart Code -------- --%>
    <%
    
    String paction = request.getParameter("action");
    // Check if an insertion is requested
    if (paction != null && paction.equals("addtocart")) {
        
        // Begin transaction
        conn.setAutoCommit(false);
        
        // Create the prepared statement and use it to
        // INSERT name description INTO the products table.
        pstmt = conn
        .prepareStatement("INSERT INTO cart (pid, uid, price, quanity) VALUES (?, ?, ?, ?)");
        
        pstmt.setString(1, pid);
        pstmt.setString(2, uid);
        pstmt.setInt(3, price);
        pstmt.setInt(4, Integer.parseInt(request.getParameter("quanity")));
        pstmt.executeUpdate();
        
        // Commit transaction
        conn.commit();
        conn.setAutoCommit(true);
    }
    %>
    
    
    
    <!-- Add an HTML table header row to format the results -->
    <tr>
    product <%=request.getParameter("productid")%>
    price <%=request.getParameter("price")%>

    </tr>
    <tr>
    quanity
    </tr>
    <tr>
    <form action="productorder.jsp" method="POST">
    <input type="hidden" name="action" value="addtocart"/>
    <td><input value="" name="quanity" size="15"/></td>
    <td><input type="submit" value="Order"/></td>
    </form>
    
    
    <%-- -------- SELECT Statement Code -------- --%>
    <%
    // Create the statement
    
    // Use the created statement to SELECT
    // the student attributes FROM the categories table.
    Statement statement = conn.createStatement();

    rs = statement.executeQuery("SELECT * FROM cart WHERE uid='"+uid+"'");
    
    %>
    <%-- -------- Iteration Code -------- --%>
    <%
    // Iterate over the ResultSet
    
    %>
    
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

