<%@ page import ="java.sql.*" %>
<%@ page import ="java.io.PrintWriter" %>
<%@ page import ="java.io.IOException" %>
<%@ page import ="javax.servlet.ServletException" %>
<%@ page import ="javax.servlet.http.HttpServlet" %>
<%@ page import ="javax.servlet.http.HttpServletRequest" %>
<%@ page import ="javax.servlet.http.HttpServletResponse" %>

<%!
    public String displayDB(){
        Connection conn = null;
        Statement stmt = null;
        String str = null;

        try{
            //Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/signup", "postgres", "8609126");
            stmt = conn.createStatement();
            
            String query = "SELECT * FROM categories;";
            ResultSet rs = stmt.executeQuery(query);
            
            str ="<table border=\"1\" style=\"width:30%\" >";
            str +="<tr>";
            str +="<td>Name</td>";
            str +="<td>Description</td>";
            str +="<td>Action</td>";
            str +="</tr>";

 
            while(rs.next()){
                String cateName= rs.getString("name");
                String cateDescription = rs.getString("description");
                str += "<tr>";
                str += "<td> <input type=\"text\" name=\"" + cateName +"\" value =\""+ cateName + "\"> </td>";
                str += "<td> <textarea rows=\"4\" cols=\"50\" name=\"" + cateName+"DESCP\">"+cateDescription  
                    + "</textarea></td>";
                str += "<td><input type=\"submit\" value=\"insert\" name=\""+cateName+"insertBtn\">" 
                    + "<input type=\"submit\" value=\"delete\" name=\""+cateName+"deleteBtn\">" 
                    + "<input type=\"submit\" value=\"update\" name=\""+cateName+"updateBtn\">	</td>";
                str += "</tr>";
            }
            str +="</table>";
            
        } catch (SQLException e) {
          //out.println("An error occured while retrieving " + "all categories: " 
            //  + e.toString());
            return "An error occured while retrieving " + "all categories: " + e.toString();
        //} catch (ClassNotFoundException e) {
        //  throw (new ServletException(e.toString()));
        } finally {
          try {
            if (stmt != null) {
              stmt.close();
            }
            if (conn != null) {
              conn.close();
            }
          } catch (SQLException ex) {
          }
        }
        
          
    //return "<h3>test works</h3>";
    return str;
    } 
%>
