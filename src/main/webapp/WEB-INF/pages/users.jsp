<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<html>
<head>
    <title>User Page</title>

    <style type="text/css">
        .tg {
            border-collapse: collapse;
            border-spacing: 0;
            border-color: #ccc;
        }

        .tg td {
            font-family: Arial, sans-serif;
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

<br/>
<br/>

<h3>User List</h3>

<c:if test="${!empty listUsers}">
    <table class="tg">
        <tr>
            <th width="80">ID</th>
            <th width="120">Name</th>
            <th width="120">Age</th>
            <th width="120">IsAdmin</th>
            <th width="60">Date</th>
            <th width="60">Edit</th>
            <th width="60">Delete</th>
        </tr>
        <c:forEach items="${listUsers}" var="user">
            <tr>
                <td>${user.id}</td>
                <td><a href="/userdata/${user.id}" target="_blank">${user.name}</a></td>
                <td>${user.age}</td>
                <td>${user.admin}</td>
                <td>${user.date}</td>
                <td><a href="<c:url value='/edit/${user.id}&${page}'/>">Edit</a></td>
                <td><a href="<c:url value='/remove/${user.id}&${page}'/>">Delete</a></td>
            </tr>
        </c:forEach>
    </table>
</c:if>

<br>

<c:if test="${page > 1}">
    <a href="/users/0">&lt;&lt;</a><span>&nbsp;</span>
</c:if>
<c:if test="${page > 0}">
    <a href="/users/${page - 1}">&lt;</a><span>&nbsp;</span>
</c:if>
<c:if test="${page > 0}">
    <a href="/users/${page - 1}">${page - 1}</a><span>&nbsp;</span>
</c:if>

   ${page}<span>&nbsp;</span>

<c:if test="${pageCount - 1 > page}">
    <a href="/users/${page + 1}">${page + 1}</a><span>&nbsp;</span>
</c:if>
<c:if test="${pageCount - 1 > page}">
    <a href="/users/${page + 1}">&gt;</a><span>&nbsp;</span>
</c:if>
<c:if test="${pageCount - 2 > page}">
    <a href="/users/${pageCount - 1}">&gt;&gt;</a><span>&nbsp;</span>
</c:if>

<br>

<h3>Add a User</h3>

<c:url var="addAction" value="/users/add/${page}"/>

<form:form action="${addAction}" commandName="user">

    <table>
        <c:if test="${!empty user.name }">
            <tr>
                <td>
                    <form:label path="id">
                        <spring:message text="ID"/>
                    </form:label>
                </td>
                <td>
                    <form:input path="id" readonly="true" size="8" disabled="true"/>
                    <form:hidden path="id"/>
                </td>
            </tr>
        </c:if>
        <tr>
            <td>
                <form:label path="name">
                    <spring:message text="name"/>
                </form:label>
            </td>
            <td>
                <form:input path="name"/>
            </td>
        </tr>
        <tr>
            <td>
                <form:label path="age">
                    <spring:message text="age"/>
                </form:label>
            </td>
            <td>
                <form:input path="age"/>
            </td>
        </tr>
        <tr>
            <td>
                <form:label path="admin">
                    <spring:message text="admin"/>
                </form:label>
            </td>
            <td>
                <form:input path="admin"/>
            </td>
        </tr>

        <tr>
            <td colspan="2">
                <c:if test="${!empty user.name}">
                    <input type="submit"
                           value="<spring:message text="Edit User"/>"/>
                </c:if>
                <c:if test="${empty user.name}">
                    <input type="submit"
                           value="<spring:message text="Add User"/>"/>
                </c:if>
            </td>
        </tr>
    </table>
</form:form>
<br>
<br>
<h3>Search user by name</h3>
<form:form action="/userSearch/${page}" >
    <table>
        <tr>
            <input type="text" name="name" placeholder="Search by name"/>
        </tr>
        <tr>
            <input type="submit"
                   value="<spring:message text="Search"/>"/>
        </tr>
    </table>
</form:form>
</body>
</html>
