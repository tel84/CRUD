<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<html>
<head>
    <title>Users Page</title>

    <style type="text/css">
        .tg {
            border-collapse: collapse;
            border-spacing: 0;
            border-color: #ccc;
        }

        .tg td {
            font-family: Arial, sans-serif;
            text-align: center;
            font-size: 14px;
            padding: 10px 5px;
            border-style: solid;
            border-width: 1px;
            overflow: hidden;
            word-break: normal;
            border-color: #ccc;
            color: #333;
            background-color: #fff;
        }

        .tg th {
            font-family: Arial, sans-serif;
            font-size: 14px;
            font-weight: normal;
            padding: 10px 5px;
            border-style: solid;
            border-width: 1px;
            overflow: hidden;
            word-break: normal;
            border-color: #ccc;
            color: #333;
            background-color: #f0f0f0;
        }

        .tg .tg-4eph {
            background-color: #f9f9f9
        }
    </style>
</head>
<body>

<a href="../../index.jsp">Back to main menu</a>

<table border="1" align="center">
    <tr>
        <th>
            <h2>Add a User</h2>

            <c:url var="addAction" value="/users/add"/>

            <form:form action="${addAction}" commandName="user">
                <table >
                    <c:if test="${!empty user.name}">
                        <tr>
                            <td>
                                <form:label path="id">
                                    <spring:message text="ID"/>
                                </form:label>
                            </td>
                            <td>
                                <form:input  path="id" readonly="true" size="8" disabled="true"/>
                                <form:hidden path="id"/>
                            </td>
                        </tr>
                    </c:if>
                    <tr>
                        <td>
                            <form:label path="name">
                                <spring:message text="Name"/>
                            </form:label>
                        </td>
                        <td>
                            <form:input path="name"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <form:label path="age">
                                <spring:message text="Age"/>
                            </form:label>
                        </td>
                        <td>
                            <form:input path="age"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <form:label path="admin">
                                <spring:message text="isAdmin"/>
                            </form:label>
                        </td>
                        <td>
                            <form:checkbox  path="admin" value="true"/>
                        </td>
                    </tr>
                    <c:if test="${!empty user.name}">
                        <tr>
                            <td>
                                <form:label path="createdDate">
                                    <spring:message text="CreatedDate"/>
                                </form:label>
                            </td>
                            <td>
                                <form:input path= "createdDate" readonly="true" size="20" disabled="true" />
                                <form:hidden path="createdDate"/>
                            </td>
                        </tr>
                    </c:if>
                    <tr>
                        <td colspan="2">
                            <c:if test="${!empty user.name}">
                                <input type="submit"
                                       value="<spring:message text="Edit User"/>">
                            </c:if>
                            <c:if test="${empty user.name}">
                                <input type="submit"
                                       value="<spring:message text="Add User"/>"/>
                            </c:if>
                        </td>
                    </tr>
                </table>
            </form:form>
        </th>
        <th>
            <h2>Find user</h2>
            <form action="/users/find" method="get">
                <input type="text" name="name" value="Enter name">
                <input type="submit" value="Find">
            </form>
        </th>
    </tr>
    <tr>
        <th colspan="2" align="left">
            <h2 align="center">User List</h2>

            <c:if test="${!empty listUsers}">
            <table class="tg">
                <tr>
                    <th width="80">ID</th>
                    <th width="120">Name</th>
                    <th width="120">Age</th>
                    <th width="120">isAdmin</th>
                    <th width="120">CreatedDate</th>
                    <th width="60">Edit</th>
                    <th width="60">Delete</th>
                </tr>
                <c:forEach items="${listUsers}" var="user">
                    <tr>
                        <td>${user.id}</td>
                        <td>${user.name}</td>
                        <td>${user.age}</td>
                            <%-- <td>${user.admin}</td>--%>
                        <td><c:if test="${user.admin}">+</c:if>
                            <c:if test="${!user.admin}">-</c:if>
                        </td>
                        <td>${user.createdDate}</td>
                        <td><a href="<c:url value='/edit/${user.id}'/>">Edit</a></td>
                        <td><a href="<c:url value='/remove/${user.id}'/>">Delete</a></td>
                    </tr>
                </c:forEach>
            </table>
            </c:if>

            <%--For displaying Previous link except for the 1st page --%>
            <c:if test="${currentPage > 1}">
       <a  href="/users?page=${currentPage - 1}">Previous</a>
        </c:if>

        <%--For displaying Page numbers.
        The when condition does not display a link for the current page--%>
        <table border="1" cellpadding="5" cellspacing="5">
            <tr>
                <c:forEach begin="1" end="${countOfPages}" var="i">
                    <c:choose>
                        <c:when test="${currentPage eq i}">
                            <td>${i}</td>
                        </c:when>
                        <c:otherwise>
                            <td><a href="/users?page=${i}">${i}</a></td>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </tr>
        </table>

        <%--For displaying Next link --%>
        <c:if test="${currentPage lt countOfPages}">
            <a href="/users?page=${currentPage + 1}">Next</a>
        </c:if>

        </th>
    </tr>
</table>
</body>
</html>
