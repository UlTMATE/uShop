<%-- 
    Document   : Cart
    Created on : 13-Jul-2015, 19:19:59
    Author     : UlTMATE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*, java.util.regex.*" isThreadSafe="false"%>

<%
    String userid = (String) pageContext.getAttribute("userid", PageContext.SESSION_SCOPE);
    if (userid == null) {
        response.sendRedirect("/uShop/");
    } else {
        Connection conn = (Connection) pageContext.getAttribute("connection", PageContext.APPLICATION_SCOPE);
        try (PreparedStatement pstmt = conn.prepareStatement("SELECT id,name,quantity as availQty, qty as userQty,price FROM cart,products WHERE cart.prod_id=products.id AND cart.userid=?");) {
            pstmt.setString(1, userid);
            ResultSet rst = pstmt.executeQuery();
            if (rst.next()) {
%>
<span id="cartMsg" style="color: red;"></span>
<table class='corders'>
    <tr>
        <!--<th></th>-->
        <th>Select</th>
        <th class='cartRow'>Name</th>
        <th class='cartRow'>Quantity</th>
        <th class='cartRow'>Price</th>
    </tr>
    <%
        int total = 0;
        do {
    %>
    <tr>
        
    <!--CheckBox-->
        <td class='check'><input type="checkbox" name="checks" value="<%=rst.getInt(1)%>" /></td>
    <!--Name-->
        <td class='cartRow'><%=rst.getString(2)%></td>
    <!--Quantity-->
        <td class='cartRow'><input name="<%=rst.getInt(1)%>" type="number" value="<%=rst.getInt(4)%>" max="<%=rst.getInt(3)%>" min="1"/></td>
    <!--Price-->
        <td class='cartRow'><%=rst.getInt(5)%></td>
    </tr>
    <%
    total+=(rst.getInt(5)*rst.getInt(4));
        } while (rst.next());
    %>
</table>
<br/><br/>
Total: Rs.<%=total%><br/><br/>
    <input type='button' class='cartBtn' id='removeCartBtn' value='RemoveSelected' onclick="removeItemsOfCart()" />
    <input type='button' class='cartBtn' id='buyCartBtn' value='BuySelected' onclick="buyItemsOfCart()" />
<%
} else {
%>
<h3>No Products In Your Cart</h3>
<%
            }
        } catch(SQLException sqlExc){
            sqlExc.printStackTrace();
        }
    }
%>
