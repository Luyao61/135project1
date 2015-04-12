<%@ page import ="java.sql.*" %>
<%@include file="categories_helper.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Catrgories</title>
    </head>
    <body>
        <% out.println(displayDB()); %>
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

		   //out.println(displayDB());
		   
		   try{
		        /********** SQL connection **********/
		        Class.forName("org.postgresql.Driver");
                Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/signup", "postgres", "8609126");
                Statement st = con.createStatement();
                
                /********** insert button **********/
                if(request.getParameter("insertBtn")!=null) {
                    
                    // check if name already exists
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
                
                
                
                /********** delete button **********/
                if(request.getParameter("deleteBtn")!=null) {
                
                    rs = st.executeQuery("SELECT FROM categories WHERE name = '" + name + "' ;");
                    if( rs.next() ){
                        st.execute("DELETE FROM categories WHERE name = '" + name + "' ;");
                    }
                    else{
                    %>
                        <p style="color:red">attempt to delete a category that does not exists;</p>
                    <%
                    }
                    
                }
                
                /********** update button **********/
                if(request.getParameter("updateBtn")!=null) {                    
                    st.execute("UPDATE categories SET description = '" + description + "' WHERE name = '" + name +"';");
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