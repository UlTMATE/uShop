<%-- 
    Document   : index
    Created on : 12-Jul-2015, 17:01:51
    Author     : UlTMATE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*, java.util.regex.*"%>

<%!
    Connection conn;

    public void init() {
//        super();
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/uShopweb", "root", "root");
        } catch (ClassNotFoundException | SQLException sqlExc) {
            sqlExc.printStackTrace();
        }
    }
%>
<%
    if (pageContext.getAttribute("conn", PageContext.APPLICATION_SCOPE) == null) {
        pageContext.setAttribute("connection", conn, PageContext.APPLICATION_SCOPE);
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="css/index.css">
        <link rel="stylesheet" type="text/css" href="css/showProducts.css">
        <script src="javascripts/index.js"></script>
        <title>uShop</title>
    </head>
    <body>
        <div id='rootDiv'>
            <header id='mainHeader'>
                <div id='titleDiv'>
                    <h1 id='title'>uShop</h1>
                </div>
                <div id="searchDiv">
                    <input type="text" id="searchField" placeholder="Search" autocomplete="on" onkeydown="searchProduct()" />
                </div>
                <%
                    boolean sessionIsOn = false;
                    if (pageContext.getAttribute("userid", PageContext.SESSION_SCOPE) != null) {
                        sessionIsOn = true;
                    }
                %>
                <div id='profileDiv'>
                    <input type='button' name='cartBtn' id='cartBtn' value='Cart' onClick="showCart()" <%if (!sessionIsOn) {%>style="display: none;"<%}%>/>
                    <input type='button' name='orderBtn' id='orderBtn' value='Orders' onClick="showOrders()" <%if (!sessionIsOn) {%>style="display: none;"<%}%> />
                    <input type='button' name='signupBtn' id='signupBtn' value='Signup' onclick="showSignup()" <%if (sessionIsOn) {%>style="display: none;"<%}%> />
                    <input type='button' name='loginBtn' id='loginBtn' value='Login' onclick="showLogin()" <%if (sessionIsOn) {%>style="display: none;"<%}%> />
                    <input type='button' name='logoutBtn' id='logoutBtn' value='Logout' onclick="logout()" <%if (!sessionIsOn) {%>style="display: none;"<%}%> />
                </div>
            </header>

            <nav id='mainNav'>
                <ul id='catList'>
                    <%
                        try (PreparedStatement pstmt = conn.prepareStatement("SELECT category FROM products GROUP BY category ORDER BY category");
                                ResultSet rst = pstmt.executeQuery();) {
                            while (rst.next()) {
                                String catName = rst.getString(1);
                    %>
                    <li class='catItem' onClick='fetchCat("<%=catName%>")' onMouseOver='showSubcategory("<%=catName%>")' onmouseout='hideSubcategory("<%=catName%>")'>
                        <%=catName%>
                        <%
                            PreparedStatement pstmt2 = conn.prepareStatement("SELECT subcategory FROM products where category=? GROUP BY subcategory order by subcategory");
                            pstmt2.setString(1, catName);
                            ResultSet rst2 = pstmt2.executeQuery();
                        %>
                    <div class='subcatDiv' id='<%=catName%>'>
                        <ul class="subcatList" onmouseover="showSubcategory('<%=catName%>')" onMouseOut='hideSubcategory("<%=catName%>")' >
                            <%
                                while (rst2.next()) {
                                    String subcatName = rst2.getString(1);
                            %>
                            <li class='subcatItem' onClick='fetch("<%=catName%>", "<%=subcatName%>")'><%=subcatName%></li>
                                <%
                                    }
                                %>
                        </ul>
                    </div>
                </li>
                    <%
                            }
                        } catch (SQLException sqlExc) {
                            sqlExc.printStackTrace();
                        }
                    %>          
                </ul>
            </nav>

            <section id='mainSection'>
                <div id='sectionCenter'>
                    <h2>Select A Category Above To Begin</h2>
                </div>
            </section>

            <footer id='mainFooter'>
                <p>Developed By Parth Khandelwal</p>
            </footer>
        </div>
        <div id='loginRootDiv' onClick="closeLoginDiv(window.event)">
            <div id='loginContentDiv'>
                <form id="loginForm">
                    <table align="center" id="loginTable">
                        <tr>
                            <td id="loginDivMsg"></td>
                        </tr>
                        <tr>
                            <td><input type='text' id='useridField' class="login" placeholder="User ID" maxlength="20" autofocus required/></td>
                        </tr>
                        <tr>
                            <td><input type='password' id='pwdField' class="login" placeholder="Password" maxlength="20" required/></td>
                        </tr>
                        <tr>
                            <td><input type='button' id='loginDivBtn' class="login" value='Login' onclick="login()"/></td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
        <div id='signupRootDiv' onClick="closeSignupDiv(window.event)">
            <div id='signupContentDiv'>
                <form id="signupForm">
                    <table align="center" id="signupTable">
                        <tr>
                            <td id="signupDivMsg"></td>
                        </tr>
                        <tr>
                            <td><input type='text' id='signupNameField' class="signup" placeholder="Full Name" maxlength="30" autofocus required/></td>
                        </tr>
                        <tr>
                            <td><input type='text' id='signupUseridField' class="signup" placeholder="User ID" maxlength="20" required/></td>
                        </tr>
                        <tr>
                            <td><input type='password' id='signupPwdField' class="signup" placeholder="Password" maxlength="20" required/></td>
                        </tr>
                        <tr>
                            <td><input type='password' id='signupConfPwdField' class="signup" placeholder="Confirm Password" maxlength="20" required/></td>
                        </tr>
                        <tr>
                            <td><input type='number' id='signupMobField' class="signup" placeholder="Mobile Number" min="1000000000" max="9999999999" required/></td>
                        </tr>
                        <tr>
                            <td><input type='button' id='signupDivBtn' class="signup" value='Signup' onclick="signup()"/></td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
        <div id="cartRootDiv" onclick="closeCartDiv(window.event)">
            <div id="cartContentDiv">

            </div>
        </div>
        <div id="ordersRootDiv" onclick="closeOrdersDiv(window.event)">
            <div id="ordersContentDiv">

            </div>
        </div>
<!--        <div id='prodDetailsRootDiv' onclick="closeProdDetails(window.event)">
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
        </div>-->
    </body>
</html>
