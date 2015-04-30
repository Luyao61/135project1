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
            
            try {
                // Registering Postgresql JDBC driver with the DriverManager
                Class.forName("org.postgresql.Driver");

                // Open a connection to the database using DriverManager
                conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Assignment#1?" +
                                                   "user=postgres&password=52362882");
            %>
            <%-- -------- BUY Code -------- --%>
                <%
                
                //String paction = request.getParameter("paction");
                // Check if an insertion is requested
                //if (paction != null && paction.equals("pinsert")) {
                    
                    // Begin transaction
                    //conn.setAutoCommit(false);
                    
                    // Create the prepared statement and use it to
                    // INSERT name description INTO the products table.
                    //pstmt = conn
                    //.prepareStatement("INSERT INTO products (sku, category, name, price) VALUES (?, ?, ?, ?)");
                    
                    //pstmt.setString(1, request.getParameter("newsku"));
                    //pstmt.setString(2, request.getParameter("category"));
                    //pstmt.setString(3, request.getParameter("pname"));
                    //pstmt.setInt(4, Integer.parseInt(request.getParameter("price")));
                    //pstmt.executeUpdate();
                    
                    // Commit transaction
                    //conn.commit();
                    //conn.setAutoCommit(true);
                //}
                %>
                
                

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                // Create the statement
                String keyword = request.getParameter("search");
                    
                Statement statement = conn.createStatement();

                // Use the created statement to SELECT
                // the student attributes FROM the categories table.
                if(keyword!=null){
                rs = statement.executeQuery("SELECT * FROM products WHERE category='"+keyword+"'");

                }else{
                rs = statement.executeQuery("SELECT * FROM products");

                }
            %>
            
            <!-- Add an HTML table header row to format the results -->
                
                
            <%=request.getParameter("search")%> category
            
            <tr>
            <form action="bproducts.jsp" method="POST">
            <input type="hidden" name="paction" value="search"/>
            <td><input value="" name="search" size="15"/></td>
            <td><input type="submit" value="Search"/></td>
            </form>
                
                
            <table border="1">
            <tr>
                <th>sku</th>
                <th>name</th>
                <th>category</th>
                <th>price</th>

            <%-- -------- Iteration Code -------- --%>
            <%
                // Iterate over the ResultSet
                while (rs.next()) {
            %>

            <tr>
                <form action="bproducts.jsp" method="POST">
                    <input type="hidden" name="paction" value="buy"/>
                    <input type="hidden" name="sku" value="<%=rs.getString("sku")%>"/>
                    
                <td>
                    <%=rs.getString("sku")%>
                </td>
                <td>
                    <%=rs.getString("name")%>
                </td>
                <td>
                    <%=rs.getString("category")%>
                </td>
                <td>
                    <%=rs.getInt("price")%>
                </td>
                <%-- Button --%>
                <td><input type="submit" value="Buy"></td>
                </form>
            </tr>

            <%
                }
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

