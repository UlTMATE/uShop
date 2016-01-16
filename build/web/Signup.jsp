<%-- 
    Document   : Signup
    Created on : 13-Jul-2015, 15:06:57
    Author     : UlTMATE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*, java.util.regex.*" session="true" isThreadSafe="false"%>
<%
    Connection conn = (Connection)pageContext.getAttribute("connection", PageContext.APPLICATION_SCOPE);
    String userid = request.getParameter("userid");
    response.setContentType("text/plain");
    try(PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM users WHERE userid=?");
            PreparedStatement pstmt2 = conn.prepareStatement("INSERT INTO users values(?,?,?,?)");){
        pstmt.setString(1, userid);
        ResultSet rst = pstmt.executeQuery();
        if(rst.next()){
            %>no<%
        } else{
            String pwd = request.getParameter("pwd");
            String username = request.getParameter("username");
            String mobNo = request.getParameter("mob");
            pstmt2.setString(1, userid);
            pstmt2.setString(2, pwd);
            pstmt2.setString(3, username);
            try{
            pstmt2.setLong(4, Long.parseLong(mobNo));
            } catch(NumberFormatException nfExc){
                System.out.println("MobNo:_"+mobNo+", userid:_"+userid);
                %>Provide Valid Number<%
            }
            pstmt2.executeUpdate();
            pageContext.setAttribute("userid", userid, PageContext.SESSION_SCOPE);
            %>yes<%
        }
    } catch(SQLException sqlExc){
        sqlExc.printStackTrace();
        %>
        Server is facing problems
        <%
    }
%>

