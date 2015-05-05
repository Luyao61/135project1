<%@ page import ="java.sql.*" %>
<%@ page import ="java.io.PrintWriter" %>
<%@ page import ="java.io.IOException" %>
<%@ page import ="javax.servlet.ServletException" %>
<%@ page import ="javax.servlet.http.HttpServlet" %>
<%@ page import ="javax.servlet.http.HttpServletRequest" %>
<%@ page import ="javax.servlet.http.HttpServletResponse" %>

<html>

<!-- ---------- Check user type ---------- -->
<%
String role = (String)session.getAttribute("userType");
String userid = (String)session.getAttribute("userid");

if (userid == null){
    out.print("<h3>You have not logged in</h3>");
}
else if(role.contains("Customer")){
    out.print("<h3>this page is available to owners only.</h3>");
}
else { 
%>


<head>
    <title>Products</title>
    <%            
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
    %>
    
    <%
    try{
                // Registering Postgresql JDBC driver with the DriverManager
                Class.forName("org.postgresql.Driver");

                // Open a connection to the database using DriverManager
                conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Assignment#1?" +
                                                   "user=postgres&password=52362882");
                Statement statement = conn.createStatement();
    %>
    <%-- -------- INSERT Code -------- --%>
    <%
                        
    
    String paction = request.getParameter("paction");
    // Check if an insertion is requested
    if (paction != null && paction.equals("pinsert")) {
        try{
            // Begin transaction
            conn.setAutoCommit(false);
        
            // Create the prepared statement and use it to
            // INSERT name description INTO the products table.


            pstmt = conn
            .prepareStatement("INSERT INTO products (sku, cid, name, price) VALUES (?, ?, ?, ?)");
        
            pstmt.setString(1, request.getParameter("newsku"));
            pstmt.setInt(2, Integer.parseInt(request.getParameter("category")));
            pstmt.setString(3, request.getParameter("pname"));
            pstmt.setInt(4, Integer.parseInt(request.getParameter("price")));
            pstmt.executeUpdate();
        
            // Commit transaction
            conn.commit();
            conn.setAutoCommit(true);
            out.print("<p style=\"color:red\">Product: "+ request.getParameter("pname") +" has been inserted</p>");
        }
        catch(Exception e){
            out.print("<p style=\"color:red\">Data modification failure, please try again!</p>");
        }
    }
    %>
        
    <%-- -------- UPDATE Code -------- --%>
    <%
    // Check if an update is requested
    if (paction != null && paction.equals("pupdate")) {
        try{
            rs = statement.executeQuery("SELECT id FROM categories WHERE name = '" + request.getParameter("category") +"'");
            if(rs.next()){
            // Begin transaction
                conn.setAutoCommit(false);
        
                // Create the prepared statement and use it to
                pstmt = conn
                .prepareStatement("UPDATE products SET sku=?,cid=?,name=?,price=? WHERE sku=?");
        
                pstmt.setString(1, request.getParameter("newsku"));
                pstmt.setInt(2, rs.getInt(1));
                pstmt.setString(3, request.getParameter("pname"));
                pstmt.setInt(4, Integer.parseInt(request.getParameter("price")));
                pstmt.setString(5, request.getParameter("sku"));
                pstmt.executeUpdate();

                // Commit transaction
                conn.commit();
                conn.setAutoCommit(true);
            }
            else{
                out.print("<p style=\"color:red\">Data modification failure, category: "+ request.getParameter("category") +" does not exist!</p>");
            }
        }
        catch(Exception e){
            out.print("<p style=\"color:red\">Data modification failure, please try again!</p>");
        }

    }
    %>
    <%-- -------- DELETE Code -------- --%>
    <%
        // Check if a delete is requested
        if (paction != null && paction.equals("pdelete")) {

            try{
                // Begin transaction
                conn.setAutoCommit(false);

                // Create the prepared statement and use it to
                // DELETE categories FROM the products table.
                pstmt = conn.prepareStatement("DELETE FROM products WHERE sku = ?");
                pstmt.setString(1, request.getParameter("sku"));
    
                pstmt.executeUpdate();

                // Commit transaction
                conn.commit();
                conn.setAutoCommit(true);
            }
            catch(Exception e){
                out.print("<p style=\"color:red\">Data modification failure, please try again!</p>");
            }
        }
    %>
    
</head>

<body>
<jsp:include page="menu.html" />
<div style="float:left; width:15%">

    <%
        rs = statement.executeQuery("SELECT id, name FROM categories");
        out.print("<p><a href='products.jsp?filter=-1&search=<%=request.getParameter('search')%'>All Categories</a></p>");
        while(rs.next()){
        %>
            <p><a href="products.jsp?filter=<%=rs.getString(1)%>"><%=rs.getString(2)%></a></p>
        <%
        }
    %>
</div>
<div style="float:right; width:85%">
<table>
    <tr>
        <td valign="top">
            <%-- -------- Open Connection Code -------- --%>

 
            <!-- Add an HTML table header row to format the results -->
            
            <!--
            <%    
            if(request.getParameter("search") == null){
                out.print("<p>All categories</p>");
            }
            else{
                out.print("<p>"+request.getParameter("search")+" categories</p>");
            }
            %>
            -->
            
            <tr>
            <form action="products.jsp" method="POST">
            <input type="hidden" name="paction" value="search"/>
            <td><input value="" name="search" size="15"/></td>
            <td><input value="<%=request.getParameter("filter")%>" name="filter" type="hidden"/><td>
            <td><input type="submit" value="Search"/></td>
            </form>
            </tr>
                
            <table border="1">
            <tr>
                <th>sku</th>
                <th>name</th>
                <th>category</th>
                <th>price</th>
            </tr>
            <%
                rs = statement.executeQuery("SELECT id, name FROM categories;");
            %>
            <tr>
                <form action="products.jsp" method="GET">
                <input type="hidden" name="paction" value="pinsert"/>
                <th><input value="" name="newsku" size="15"/></th>
                <th><input value="" name="pname" size="15"/></th>
                <th>
                    <select name="category">  
                        <% while(rs.next()){
                        %>    
                           <option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
                        <%
                            }
                        %>
                        
                    </select>
                </th>
                <th>
                    <input value="" name="price" size="15"/>
                    <%
                        if(request.getParameter("filter") != null){
                        %>
                            <input value="<%=request.getParameter("filter")%>" name="filter" type="hidden"/>
                        <%
                        }
                        if(request.getParameter("search") != null){
                        %>
                            <input value="<%=request.getParameter("search")%>" name="search" type="hidden"/>
                        <%
                        }
                    %>
                </th>
                <th><input type="submit" value="Insert"/></th>
            </form>
            </tr>


            <%-- -------- SELECT Statement Code -------- --%>
            <%
                // Create the statement
                String search = request.getParameter("search");
//                out.print(search+"\n");
                int filter;
                try{
                    filter =  Integer.parseInt(request.getParameter("filter"));
                }catch(Exception e){
                    filter = -1;
                }

                    
                // Use the created statement to SELECT
                // the student attributes FROM the categories table.
                if(filter != -1 && search == null ){
                    rs = statement.executeQuery("SELECT p.sku, p.name, c.name as category, p.price"
                                                +" FROM categories c, products p"
                                                +" WHERE p.cid= c.id and cid ="+filter
                                                +" order by p.id asc;");   
//                out.print(1);
                }
                else if(filter == -1 && search == null){
                    rs = statement.executeQuery("SELECT p.sku, p.name, c.name as category, p.price"
                                                +" FROM categories c, products p"
                                                +" WHERE p.cid= c.id"
                                                +" order by p.id asc;");
//                out.print(2);
                }
                else if(filter == -1 && search != null){
                    rs = statement.executeQuery("SELECT p.sku, p.name, c.name as category, p.price"
                                                +" FROM categories c, products p"
                                                +" WHERE p.cid= c.id"
                                                +" AND"
                                                +" p.name LIKE '%"+search+"%'"
                                                +" order by p.id asc;"); 
//                out.print(3);
                }
                else if(filter != -1 && search != null ){
                    rs = statement.executeQuery("SELECT p.sku, p.name, c.name as category, p.price"
                                                +" FROM categories c, products p"
                                                +" WHERE p.cid= c.id and cid = '"+filter+"'"
                                                +" and p.name LIKE '%"+search+"%'"
                                                +" order by p.id asc;"); 
//                    out.print(4);
                }
            %>
            <%-- -------- Iteration Code -------- --%>
            <%
                // Iterate over the ResultSet
                while (rs.next()) {
            %>

            <tr>
                <form action="products.jsp" method="POST">
                    <input type="hidden" name="paction" value="pupdate"/>
                    <input type="hidden" name="sku" value="<%=rs.getString("sku")%>"/>
                    
                <td>
                    <input value="<%=rs.getString("sku")%>" name="newsku" size="15"/>
                </td>
                <td>
                    <input value="<%=rs.getString("name")%>" name="pname" size="15"/>
                </td>
                <td>
                <input value="<%=rs.getString("category")%>" name="category" size="15"/>
                </td>
                <td>
                <input value="<%=rs.getInt("price")%>" name="price" size="15"/>
                </td>
                    <%
                        if(request.getParameter("filter") != null){
                        %>
                            <input value="<%=request.getParameter("filter")%>" name="filter" type="hidden"/>
                        <%
                        }
                        if(request.getParameter("search") != null){
                        %>
                            <input value="<%=request.getParameter("search")%>" name="search" type="hidden"/>
                        <%
                        }
                    %>
                <%-- Button --%>
                <td><input type="submit" value="Update"></td>
                </form>
                <form action="products.jsp" method="POST">
                <input type="hidden" name="paction" value="pdelete"/>
                <input type="hidden" name="sku" value="<%=rs.getString("sku")%>"/>
                    <%
                        if(request.getParameter("filter") != null){
                        %>
                            <input value="<%=request.getParameter("filter")%>" name="filter" type="hidden"/>
                        <%
                        }
                        if(request.getParameter("search") != null){
                        %>
                            <input value="<%=request.getParameter("search")%>" name="search" type="hidden"/>
                        <%
                        }
                    %>
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
</div>
</body>
<%
}
%>

</html>

