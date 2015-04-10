<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Catrgories</title>
    </head>
    <body>
        <form>
            Name:<br>
            <input type="text" name="ctgrName" placeholder="unique name" required>
            <br>
            Product description:
            <br>
            <textarea rows="4" cols="50" name="description">enter product categories here.</textarea>
            <br>
		    <input type="submit" value="insert" name="insertBtn">
		    <input type="submit" value="delete" name="deleteBtn">			
		    <input type="submit" value="update" name="updateBtn">	
		    <br>
		</form>

		<%
		   String name = request.getParameter("ctgrName");
		   String description = request.getParameter("description");    
		   ResultSet rs;

		   
		   
		   try{
		        Class.forName("org.postgresql.Driver");
                Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/signup", "postgres", "8609126");
                Statement st = con.createStatement();
                
                if(request.getParameter("insertBtn")!=null) {
                
                    rs = st.executeQuery("SELECT * FROM categories WHERE name = '" + name + "' ;");
                    if( rs.next() ){
                    %>
                        <p style="color:red">name already exists;</p>
                    <%
                    }
                    else{
                        st.execute("INSERT INTO categories(name, description) values('"+name+"','"+description+"');");
                    }
                }
                if(request.getParameter("deleteBtn")!=null) {
                    %>
                    <h3>delete</h3>
                    <%
                }		    
                if(request.getParameter("updateBtn")!=null) {
                    java.util.Date d = new java.util.Date();
                    System.out.println(d.toString()); 
                    out.println(d.toString()); 
                }
            }
            catch(SQLException e){
            %>
                <p style="color:red">requested data modification failed<p>
            <%    
            }
		%>
    </body>
</html>