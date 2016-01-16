<%-- 
    Document   : SearchProduct
    Created on : 15-Jul-2015, 20:08:41
    Author     : UlTMATE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*, java.util.regex.*"%>

<div id='sectionCenter' style='display: block;'>
    <%
        String searchText = request.getParameter("searchText");
        String tokenizedSearchText = "%";
        StringTokenizer stroker = new StringTokenizer(searchText);
        while (stroker.hasMoreElements()) {
            tokenizedSearchText += stroker.nextToken() + "%";
        }
        Connection conn = (Connection) pageContext.getAttribute("connection", PageContext.APPLICATION_SCOPE);
        String query;
        query = "SELECT * FROM products WHERE name like ? OR description like ? OR subcategory like ? OR category LIKE ? ORDER BY name, description, subcategory, category";
        try (PreparedStatement pstmt = conn.prepareStatement(query);) {
            for (int i = 1; i < 5; i++) {
                pstmt.setString(i, tokenizedSearchText);
            }
            ResultSet rst = pstmt.executeQuery();
            Blob image;
            byte[] imgData = null;
            String imgDataBase64;
            if (rst.next()) {
                do {
                    image = rst.getBlob("image");
//                System.out.println(rst.getString("id"));
                    imgData = image.getBytes(1, (int) image.length());
                    imgDataBase64 = new String(Base64.getEncoder().encode(imgData));
    %>
    <div class='prodDiv' onclick="showProdDetails(<%=rst.getInt(1)%>)">
        <table id='<%=rst.getInt(1)%>'>
            <tr>
                <td>
                    <center>
                        <div style="width: 48%;">
                            <img  name='<%=rst.getInt(1)%>' class='image' src='data:image/gif;base64,<%=imgDataBase64%>' alt='image' />
                        </div>
                    </center>
        </td>
            </tr>
            <tr>
                <td><%=rst.getString("name")%></td>
            </tr>
            <tr>
                <td>Rs.<%=rst.getInt("price")%></td>
            </tr>
            <tr>
                <td>Qty.:<%=rst.getInt("quantity")%></td>
            </tr>
            <tr>
                <td hidden><%=rst.getString("description")%></td>
            </tr>
        </table>
    </div>
    <%
                } while (rst.next());
            } else {
                out.println("<h2 style='color: red;'>No Products Found. Try Different Search Query</h2>");
            }
        }
    %>
</div>

<div id='prodDetailsRootDiv' onclick="closeProdDetails(window.event)">
    <div id='prodDetailsContentDiv'>
        <input type='hidden' id='prodId'/>
        <img id='prodDetailImg' />
        <span id='prodDetailName'></span><br/>
        <span id='prodDetailPrice'></span><br/>
        <span id='prodDetailQty'></span><br>
        <input class='prodDet' type='button' id='addToCartBtn' value='Add To Cart' onclick='addItemToCart()' />
        <input class='prodDet' type='button' id='buyBtn' value='Buy' onclick='addItemToOrders()'/><br/><br/>
        <h4 id='prodDetailMsg' style="color: red;"></h4>
        <textarea id='prodDetailDesc'></textarea><br/>
    </div>
</div>
