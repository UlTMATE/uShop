<%-- 
    Document   : Login
    Created on : 12-Jul-2015, 17:42:39
    Author     : UlTMATE
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*, java.util.regex.*" session="true" isThreadSafe="false"%>
<%
    Connection conn = (Connection)pageContext.getAttribute("connection", PageContext.APPLICATION_SCOPE);
    String userid = request.getParameter("userid");
    String pwd = request.getParameter("pwd");
    response.setContentType("text/plain");
    try(PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM users WHERE userid=? AND pwd=?")){
        pstmt.setString(1, userid);
        pstmt.setString(2, pwd);
        ResultSet rst = pstmt.executeQuery();
        if(rst.next()){
            session.setAttribute("userid",userid);
            %>yes<%
        } else{
            %>no<%
        }
    } catch(SQLException sqlExc){
        sqlExc.printStackTrace();
        %>
        Server is facing problems
        <%
    }
%>
