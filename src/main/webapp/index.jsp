<%-- index.jsp: Root redirect to login or dashboard --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Redirect root URL to appropriate page based on session
    if (session != null && session.getAttribute("loggedIn") != null) {
        response.sendRedirect(request.getContextPath() + "/dashboard");
    } else {
        response.sendRedirect(request.getContextPath() + "/login");
    }
%>
