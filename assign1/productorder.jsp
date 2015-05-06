<%@ page import ="java.sql.*" %>
<%@ page import ="java.io.PrintWriter" %>
<%@ page import ="java.io.IOException" %>
<%@ page import ="javax.servlet.ServletException" %>
<%@ page import ="javax.servlet.http.HttpServlet" %>
<%@ page import ="javax.servlet.http.HttpServletRequest" %>
<%@ page import ="javax.servlet.http.HttpServletResponse" %>

<html>
<head>
<title> Product order</title>
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
        
<%
    String role = (String)session.getAttribute("userType");
    if(role.contains("Customer")){
%>
    <div align="right">    
        <p><a href="buycart.jsp">Check out</a></p> 
    </div>
<%
    }
%>


<%
    if( request.getParameter("buy") == null){
%>
    <p style="color:red">invalid request</p>
    <p><a href="home.jsp">Click here to go back to home page</a></p>
<%
    }
    else{
%>
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
String price_str = (String)request.getParameter("price");
Integer price = Integer.parseInt(price_str);

try {

    // Registering Postgresql JDBC driver with the DriverManager
    Class.forName("org.postgresql.Driver");
    
    // Open a connection to the database using DriverManager
    conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Assignment#1?" +
                                       "user=postgres&password=52362882");
  //add to cart
    
    String paction = request.getParameter("action");
    // Check if an insertion is requested
    if (paction != null && paction.equals("addtocart")) {
        if (request.getParameter("quantity") != null && !request.getParameter("quantity").isEmpty() && request.getParameter("quantity").trim().length() != 0 && Integer.parseInt(request.getParameter("quantity")) != 0){
            try{
                // Begin transaction
                conn.setAutoCommit(false);

                // Create the prepared statement and use it to
                // INSERT name description INTO the products table.
                pstmt = conn
                .prepareStatement("INSERT INTO cart (uid, pid, quantity, price) VALUES (?, ?, ?, ?)");
                pstmt.setString(1, request.getParameter("uid"));
                pstmt.setInt(2, Integer.parseInt(request.getParameter("pid")));
                pstmt.setInt(3, Integer.parseInt(request.getParameter("quantity")));
                pstmt.setInt(4, Integer.parseInt(request.getParameter("price")));
                pstmt.executeUpdate();

                // Commit transaction
                conn.commit();
                conn.setAutoCommit(true);
            }catch(Exception e){
                out.print("<p style='color:red'>sorry, an exception occurred.</p>");
            }

        }
        else{
            out.print("<p style='color:red'>please enter a valid quantity!</p>");
        }
    }
    %>
    
    
    
    <!-- Add an HTML table header row to format the results -->
    <p>
    product name: <%=request.getParameter("productname")%>
    </p>
    <p>
    price: $<%=request.getParameter("price")%>
    </p>
    <p>
    quantity
    </p>
    
    <tr>
    <form action="productorder.jsp?productid=<%=request.getParameter("productid")%>&price=<%=Integer.parseInt(price_str)%>" method="POST">
    <input type="hidden" name="action" value="addtocart"/>
    <input type="hidden" name="pid" value="<%=request.getParameter("productid")%>"/>
    <input type="hidden" name="sku" value="<%=request.getParameter("sku")%>"/>

    <input type="hidden" name="uid" value="<%=(String)session.getAttribute("userid")%>"/>
    <input type="hidden" name="price" value="<%=Integer.parseInt(price_str)%>"/>
    <input type="hidden" name="buy" value="browsingproduct"/>
    <td><input value="" name="quantity" size="15"/></td>
    <td><input type="submit" value="Order"/></td>
    </form>
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
         
    <p><a href="bproducts.jsp?filter=-1&search=%3C%=request.getParameter%28">countinue shopping</a></p>
            <p><a href="buycart.jsp">Check out</a></p> 


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
<%
}
%>
</body>
<%
}
%>

</html>

