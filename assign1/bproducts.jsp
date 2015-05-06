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
String userid = (String)session.getAttribute("userid");

if (userid == null){
    out.print("<h3>You have not logged in</h3>");
    out.print("<p><a href='index.jsp'>click here to login in</a></p>");
}
else{
%>
<head>
    <title>Procudts browsing</title>
        <%-- -------- Open Connection Code -------- --%>
        <%
    
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String pid = null;
            try {
            // Registering Postgresql JDBC driver with the DriverManager
            Class.forName("org.postgresql.Driver");

            // Open a connection to the database using DriverManager
            conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Assignment#1?" +
                                               "user=postgres&password=52362882");
            Statement statement = conn.createStatement();
        %>
</head>
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
<div style = "float:left; width:20%">
<jsp:include page="menu.html" />
</div>

<div style="float:left; width:15%">

    <%
        rs = statement.executeQuery("SELECT id, name FROM categories");
        out.print("<p><a href='bproducts.jsp?filter=-1&search=<%=request.getParameter('search')%'>All Categories</a></p>");
        while(rs.next()){
        %>
            <p><a href="bproducts.jsp?filter=<%=rs.getString(1)%>"><%=rs.getString(2)%></a></p>
        <%
        }
    %>
</div>
<div style="float:right; width:65%">
<table>
    <tr>
        <td valign="top">



                
            
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
                    rs = statement.executeQuery("SELECT p.id,p.sku, p.name, c.name as category, p.price"
                                                +" FROM categories c, products p"
                                                +" WHERE p.cid= c.id and cid ="+filter
                                                +" order by p.id asc;");   
//                out.print(1);
                }
                else if(filter == -1 && search == null){
                    rs = statement.executeQuery("SELECT p.id,p.sku, p.name, c.name as category, p.price"
                                                +" FROM categories c, products p"
                                                +" WHERE p.cid= c.id"
                                                +" order by p.id asc;");
//                out.print(2);
                }
                else if(filter == -1 && search != null){
                    rs = statement.executeQuery("SELECT p.id,p.sku, p.name, c.name as category, p.price"
                                                +" FROM categories c, products p"
                                                +" WHERE p.cid= c.id"
                                                +" AND"
                                                +" p.name LIKE '%"+search+"%'"
                                                +" order by p.id asc;"); 
//                out.print(3);
                }
                else if(filter != -1 && search != null ){
                    rs = statement.executeQuery("SELECT p.id,p.sku, p.name, c.name as category, p.price"
                                                +" FROM categories c, products p"
                                                +" WHERE p.cid= c.id and cid = '"+filter+"'"
                                                +" and p.name LIKE '%"+search+"%'"
                                                +" order by p.id asc;"); 
//                    out.print(4);
                }
            %>
            <!-- Add an HTML table header row to format the results -->
                
                
            <%=request.getParameter("search")%> product name
            
            <tr>
            <form action="bproducts.jsp" method="POST">
            <input type="hidden" name="paction" value="search"/>
            <td><input value="" name="search" size="15"/></td>
            <td><input value="<%=request.getParameter("filter")%>" name="filter" type="hidden"/><td>
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
                    int id=rs.getInt("id");
            %>

            <tr>
                <form action="bproducts.jsp" method="POST">
                    <input type="hidden" name="paction" value="buy"/>
                    <input type="hidden" name="sku" value="<%=rs.getString("sku")%>"/>
                    
                <td>
                    <%pid =  rs.getString("sku");
                    out.print(pid);
                    %>
                </td>
                <td>
                    <%String productname = rs.getString("name");%>
                    <%=productname%>
                </td>
                <td>
                    <%=rs.getString("category")%>
                </td>
                <td>
                    <%out.print("$");%>
                    <%=rs.getInt("price")%>
                    <% Integer price=rs.getInt("price");
                    %>
                </td>
            <%-- Button --%>
                    <%out.println("<td><a href=\"productorder.jsp?buy=browsingproduct&productname="+productname+"&productid="+id+"&price="+price+"&sku="+pid+"\">BuyIt</a></td>");%>
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
<div>
</body>
<%
}
%>

</html>

