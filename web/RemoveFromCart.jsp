<%-- 
    Document   : RemoveFromCart
    Created on : 16-Jul-2015, 00:26:42
    Author     : UlTMATE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*, java.util.regex.*" isThreadSafe="false"%>
<%
    String userid = (String) pageContext.getAttribute("userid", PageContext.SESSION_SCOPE);
    if (userid == null) {
        out.println("Login To Continue");
    } else {
        int prod_id = Integer.parseInt(request.getParameter("prod_id"));
        Connection conn = (Connection) pageContext.getAttribute("connection", PageContext.APPLICATION_SCOPE);
        try (PreparedStatement pstmt = conn.prepareStatement("DELETE FROM cart WHERE prod_id=? AND userid=?");) {
            pstmt.setInt(1, prod_id);
            pstmt.setString(2, userid);
            pstmt.executeUpdate();
            out.println("Done");
        } catch (SQLException sqlExc){
            out.println("An Error Occured (S)");
        }
    }
%>
