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
            <%-- -------- INSERT Code -------- --%>
                <%
                
                String action = request.getParameter("action");
                // Check if an insertion is requested
                if (action != null && action.equals("insert")) {
                    
                    // Begin transaction
                    conn.setAutoCommit(false);
                    
                    // Create the prepared statement and use it to
                    // INSERT name description INTO the categories table.
                    pstmt = conn
                    .prepareStatement("INSERT INTO products (sku,category,name,price) VALUES (?,?,?,?)");
                    pstmt.setString(1, request.getParameter("sku"));
                    pstmt.setString(2, request.getParameter("category"));
                    pstmt.setString(3, request.getParameter("name"));
                    pstmt.setInt(4, Integer.parseInt(request.getParameter("price")));
                    
                    int rowCount = pstmt.executeUpdate();
                    
                    // Commit transaction
                    conn.commit();
                    conn.setAutoCommit(true);
                }
                %>
                
                <%-- -------- UPDATE Code -------- --%>
                <%
                //hahahah
                // Check if an update is requested
                if (action != null && action.equals("update")) {
                    
                    // Begin transaction
                    conn.setAutoCommit(false);
                    
                    // Create the prepared statement and use it to
                    pstmt = conn
                    .prepareStatement("UPDATE products SET sku = ?,category = ?,name=?, price=? WHERE sku=?");
                    
                    pstmt.setString(1, request.getParameter("sku"));
                    pstmt.setString(2, request.getParameter("category"));
                    pstmt.setString(3, request.getParameter("name"));
                    pstmt.setInt(4, Integer.parseInt(request.getParameter("price")));
                    pstmt.setString(5, request.getParameter("sku"));
                    
                    // Commit transaction
                    conn.commit();
                    conn.setAutoCommit(true);

                }
                    %>
            <%-- -------- DELETE Code -------- --%>
            <%
                // Check if a delete is requested
                if (action != null && action.equals("delete")) {

                    // Begin transaction
                    conn.setAutoCommit(false);

                    // Create the prepared statement and use it to
                    // DELETE categories FROM the products table.
                    pstmt = conn.prepareStatement("DELETE FROM products WHERE sku = ?");
                    pstmt.setString(1, request.getParameter("sku"));
            
                    int rowCount = pstmt.executeUpdate();

                    // Commit transaction
                    conn.commit();
                    conn.setAutoCommit(true);
                }
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

            <form action="products.jsp" method="POST">
            <input type="hidden" name="action" value="search"/>
            <td><input value="" name="search" size="15"/></td>
            <td><input type="submit" value="Search"/></td>

            <table border="1">
            <tr>
                <th>sku</th>
                <th>name</th>
                <th>category</th>
                <th>price</th>
                

            </tr>

            <tr>
                <form action="products.jsp" method="POST">
                <input type="hidden" name="action" value="insert"/>
                <th><input value="" name="sku" size="15"/></th>
                <th><input value="" name="name" size="15"/></th>
                <th><input value="" name="category" size="15"/></th>
                <th><input value="" name="price" size="15"/></th>

                    <th><input type="submit" value="Insert"/></th>
            </form>
            </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                // Iterate over the ResultSet
                while (rs.next()) {
            %>

            <tr>
                <form action="products.jsp" method="POST">
                    <input type="hidden" name="action" value="update"/>
                    <input type="hidden" name="sku" value="<%=rs.getString("sku")%>"/>
                    
                            <%-- Get the name --%>
                <td>
                    <input value="<%=rs.getString("sku")%>" name="sku" size="15"/>
                </td>
                <%-- Get the description --%>
                <td>
                    <input value="<%=rs.getString("name")%>" name="name" size="15"/>
                </td>
                <td>
                <input value="<%=rs.getString("category")%>" name="category" size="15"/>
                </td>
                <td>
                <input value="<%=rs.getInt("price")%>" name="price" size="15"/>
                </td>
                <%-- Button --%>
                <td><input type="submit" value="Update"></td>
                </form>
                <form action="products.jsp" method="POST">
                <input type="hidden" name="action" value="delete"/>
                <input type="hidden" name="sku" value="<%=rs.getString("sku")%>"/>
                <%-- Button --%>
                <td><input type="submit" value="Delete"/></td>
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

