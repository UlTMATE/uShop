<%-- 
    Document   : ShowProducts
    Created on : 12-Jul-2015, 19:48:37
    Author     : UlTMATE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*, java.util.regex.*"%>
<!--<script type="text/javascript">
    var link = document.createElement("link");
    link.setAttribute("rel", "stylesheet");
    link.setAttribute("href", "css/showProducts.css");
    var head = document.getElementsByTagName("head")[0];
    head.appendChild(link);
    document.body.event("onscroll", "checkScroll()");
</script>-->

<div id='sectionCenter' style='display: block;'>
    <%
        String category = request.getParameter("cat");
        String subcat = request.getParameter("subcat");
        Connection conn = (Connection)pageContext.getAttribute("connection",PageContext.APPLICATION_SCOPE);
        String query;
        if(subcat==null){
            query="SELECT * FROM products WHERE category=?";
        } else {
            query="SELECT * FROM products WHERE category=? and subcategory=?";
        }
        try(PreparedStatement pstmt = conn.prepareStatement(query);){
            pstmt.setString(1, category);
            if(subcat!=null){
                pstmt.setString(2, subcat);
            }
            ResultSet rst = pstmt.executeQuery();
            Blob image;
            byte[] imgData = null;
            String imgDataBase64;
            while(rst.next()){
                image = rst.getBlob("image");
//                System.out.println(rst.getString("id"));
                imgData = image.getBytes(1,(int)image.length());
                imgDataBase64=new String(Base64.getEncoder().encode(imgData));
                %>
                <div class='prodDiv' onclick="showProdDetails(<%=rst.getInt(1)%>)">
                    <table id='<%=rst.getInt(1)%>'>
<!--                        <tr>
                            <td><%=rst.getInt(1)%></td>
                        </tr>-->
                        <tr>
                            <td>
                                <center>
                                <div style="width: 48%;">
                                    
                                    <img  name='<%=rst.getInt(1)%>' class='image' src='data:image/gif;base64,<%=imgDataBase64%>' alt='<%=rst.getString("name")%>' />
                                   
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