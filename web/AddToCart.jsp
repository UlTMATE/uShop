<%-- 
    Document   : AddToCart
    Created on : 13-Jul-2015, 20:50:35
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
        try (PreparedStatement pstmt = conn.prepareStatement("SELECT quantity as availQty, qty as userQty FROM cart,products WHERE cart.prod_id=products.id AND cart.prod_id=? AND cart.userid=?");) {
            pstmt.setInt(1, prod_id);
            pstmt.setString(2, userid);
            ResultSet rst = pstmt.executeQuery();
            if (rst.next()) {
                out.println("Item Already Exists In Your Cart");
            } else {
                try (PreparedStatement pstmt3 = conn.prepareStatement("SELECT quantity FROM products WHERE products.id=?");
                        PreparedStatement pstmt4 = conn.prepareStatement("INSERT INTO cart values(?,?,?)");) {
                    pstmt3.setInt(1, prod_id);
                    ResultSet rst2 = pstmt3.executeQuery();
                    rst2.next();
                    if (rst2.getInt(1) == 0) {
%>
Product Out Of Stock
<%
} else {
    pstmt4.setInt(1, prod_id);
    pstmt4.setString(2, userid);
    pstmt4.setInt(3, 1);
    pstmt4.executeUpdate();
%>
Product Added To Your Cart
<%
                    }
                }
            }
        } catch (SQLException sqlExc) {
            sqlExc.printStackTrace();
        }
    }
%>
