<%-- 
    Document   : AddToOrders
    Created on : 15-Jul-2015, 20:44:25
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
        int qty = Integer.parseInt(request.getParameter("qty"));
        Connection conn = (Connection) pageContext.getAttribute("connection", PageContext.APPLICATION_SCOPE);
        try(PreparedStatement pstmt = conn.prepareStatement("SELECT quantity,price,name FROM products where id=?")){
            pstmt.setInt(1, prod_id);
            ResultSet rst = pstmt.executeQuery();
            rst.next();
            if(rst.getInt(1)>=qty){
                try(PreparedStatement pstmt2 = conn.prepareStatement("INSERT INTO orders VALUES(?,?,?,?,?)")){
                    pstmt2.setInt(1, prod_id);
                    pstmt2.setInt(2, rst.getInt(2));
                    pstmt2.setInt(3, qty);
                    pstmt2.setDate(4, new java.sql.Date(new java.util.Date().getTime()));
                    pstmt2.setString(5, userid);
                    pstmt2.executeUpdate();
                    try(PreparedStatement pstmt3 = conn.prepareStatement("UPDATE products SET quantity=? WHERE id=?")){
                        pstmt3.setInt(1, rst.getInt(1)-qty);
                        pstmt3.setInt(2, prod_id);
                        pstmt3.executeUpdate();
                    }
                    out.println("Thank You For Shopping");
                }
            } else {
                if(qty == 1){
                    out.println("Product Out Of Stock");
                } else {
                    out.println("Only " + rst.getInt(1) + " Units Available Of "+rst.getString(3));
                }
            }
        } catch(SQLException sqlExc){
            sqlExc.printStackTrace();
            out.println("An Error Occured, Try Again");
        }
    }
%>
