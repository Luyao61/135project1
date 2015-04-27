<%@ page import ="java.sql.*" %>
<%@ page import ="java.io.PrintWriter" %>
<%@ page import ="java.io.IOException" %>
<%@ page import ="javax.servlet.ServletException" %>
<%@ page import ="javax.servlet.http.HttpServlet" %>
<%@ page import ="javax.servlet.http.HttpServletRequest" %>
<%@ page import ="javax.servlet.http.HttpServletResponse" %>

<html>
<head> 
    <title>Categories</title>

</head>

<body>
    <%
        String role = (String)session.getAttribute("userType");
        String id = (String)session.getAttribute("userid");

        if (id == null){
            out.print("<h3>You have not logged in</h3>");
        }
        else if(role.contains("Customer")){
            out.print("<h3>this page is available to owners only.</h3>");
        }
        else { 
    %>
<table>
    <tr>
        <td valign="top">
            <%-- -------- Include menu HTML code -------- --%>
            <jsp:include page="menu.html" />
        </td>
        <td>
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
                String userid = (String)session.getAttribute("userid");

                String action = request.getParameter("action");
                // Check if an insertion is requested
                if (action != null && action.equals("insert")) {

                    // Begin transaction
                    conn.setAutoCommit(false);

                    // Create the prepared statement and use it to
                    // INSERT name description INTO the categories table.
                    pstmt = conn
                    .prepareStatement("INSERT INTO categories (name,description,owner) VALUES (?, ?,?)");
                    pstmt.setString(1, request.getParameter("name"));
                    pstmt.setString(2, request.getParameter("description"));
                    pstmt.setString(3, (String)session.getAttribute("userid"));
                    int rowCount = pstmt.executeUpdate();

                    // Commit transaction
                    conn.commit();
                    conn.setAutoCommit(true);
                }
            %>
            
            <%-- -------- UPDATE Code -------- --%>
            <%
                // Check if an update is requested
                if (action != null && action.equals("update")) {

                    // Begin transaction
                    conn.setAutoCommit(false);

                    // Create the prepared statement and use it to
                    pstmt = conn
                    .prepareStatement("UPDATE categories SET name = ?, description = ? WHERE name = ?");

                    pstmt.setString(1, request.getParameter("nameNew"));
                    pstmt.setString(2, request.getParameter("description"));
                    pstmt.setString(3, request.getParameter("name"));
                    
                    int rowCount = pstmt.executeUpdate();

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
                    // DELETE categories FROM the categories table.
                    pstmt = conn.prepareStatement("DELETE FROM categories WHERE name = ?");
                    pstmt.setString(1, request.getParameter("name"));
            
                    int rowCount = pstmt.executeUpdate();

                    // Commit transaction
                    conn.commit();
                    conn.setAutoCommit(true);
                }
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                // Create the statement
                
                Statement statement = conn.createStatement();

                // Use the created statement to SELECT
                // the student attributes FROM the categories table.
                rs = statement.executeQuery("SELECT * FROM categories where owner='"+userid+"'");
     
            %>
            
            
            
            
            
            <!-- Add an HTML table header row to format the results -->
            
                <p><%=session.getAttribute("userid")%>'s categories</p>

            <table border="1">
            <tr>
                <th>Name</th>
                <th>Description</th>
                <th>Action</th>
            </tr>

            <tr>
                <form action="categories.jsp" method="POST">
                    <input type="hidden" name="action" value="insert"/>
                    <td><input value="" name="name" size="15"/></td>
                    <td><input value="" name="description" size="40"/></td>
                    <td><input type="submit" value="Insert"/></td>                    
                </form>
            </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                // Iterate over the ResultSet
                while (rs.next()) {

            %>
            <tr>
                <form action="categories.jsp" method="POST">
                    <input type="hidden" name="action" value="update"/>
                    <input type="hidden" name="name" value="<%=rs.getString("name")%>"/>
                    
                    <%-- Get the name --%>
                    <td>
                        <input value="<%=rs.getString("name")%>" name="nameNew" size="15"/>
                    </td>
                    <%-- Get the description --%>
                    <td>
                        <input value="<%=rs.getString("description")%>" name="description" size="40"/>
                    </td>
                    <%-- Button --%>
                    <td>
                        <input type="submit" value="Update">
                    </td>
                </form>
                <form action="categories.jsp" method="POST">
                    <input type="hidden" name="action" value="delete"/>
                    <input type="hidden" name="name" value="<%=rs.getString("name")%>"/>
                    <%-- Button --%>
                    <td>
                        <input type="submit" value="Delete"/>
                    </td>
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
<%
}
%>
</body>

</html>

