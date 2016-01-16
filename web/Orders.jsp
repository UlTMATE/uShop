<%-- 
    Document   : Orders
    Created on : 13-Jul-2015, 19:20:14
    Author     : UlTMATE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*, java.util.regex.*" isThreadSafe="false"%>

<%
    String userid = (String) pageContext.getAttribute("userid", PageContext.SESSION_SCOPE);
    if (userid == null) {
//        response.sendRedirect("/uShop/");
        %>
        Login To Continue
        <%
    } else {
        Connection conn = (Connection) pageContext.getAttribute("connection", PageContext.APPLICATION_SCOPE);
        try (PreparedStatement pstmt = conn.prepareStatement("SELECT id, name, prod_price, qty, purchase_date FROM orders,products WHERE orders.prod_id=products.id AND orders.userid=?");) {
            pstmt.setString(1, userid);
            ResultSet rst = pstmt.executeQuery();
            if (rst.next()) {
%>
<table class='corders'>
    <tr>
        <th class='ordersRow'>Name</th>
        <th class='ordersRow'>Price</th>
        <th class='ordersRow'>Quantity</th>
        <th class='ordersRow'>Purchase Date</th>
    </tr>
    <%
        int total = 0;
        do {
    %>
    <tr>
        <td class='ordersRow'><%=rst.getString(2)%></td>

        <td class='ordersRow'>Rs. <%=rst.getString(3)%></td>

        <td class='ordersRow'><%=rst.getString(4)%></td>

        <td class='ordersRow'><%=rst.getString(5)%></td>
    </tr>
    <%
        total+=(rst.getInt(3)*rst.getInt(4));
        } while (rst.next());
    %>
</table>
    <br/>
    Total : Rs. <%=total%>
<%
} else {
%>
<h3>You Haven't Ordered Anything Yet</h3>
<%
            }
        }
    }
%>
