<%-- 
    Document   : Logout
    Created on : 13-Jul-2015, 00:13:39
    Author     : UlTMATE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>

<%
    session.invalidate();
    response.sendRedirect("/uShop/");
%>
