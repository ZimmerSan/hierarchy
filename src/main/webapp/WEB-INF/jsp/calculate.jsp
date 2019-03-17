<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="parts/meta.jsp" %>
    <%@ include file="parts/head.jsp" %>

    <title>Hello boy!</title>
</head>
<body>
<%--<h2>Submitted Problem Information</h2>--%>
<%--<table>--%>
    <%--<tr>--%>
        <%--<td>Name :</td>--%>
        <%--<td>${problem.name}</td>--%>
    <%--</tr>--%>
    <%--<tr>--%>
        <%--<td>Factors Count :</td>--%>
        <%--<td>${problem.factorsCount}</td>--%>
    <%--</tr>--%>
<%--</table>--%>

<%--<h3>Submitted Factors Details</h3>--%>
<%--<table>--%>
    <%--<tr>--%>
        <%--<th>Code</th>--%>
        <%--<th>Name</th>--%>
    <%--</tr>--%>
    <%--<c:forEach items="${problem.factors}" var="factor" varStatus="status">--%>
        <%--<tr>--%>
            <%--<td>${factor.code}</td>--%>
            <%--<td>${factor.name}</td>--%>
        <%--</tr>--%>
    <%--</c:forEach>--%>
<%--</table>--%>

<%--<h3>Entered Alternatives</h3>--%>
<%--<table>--%>
    <%--<tr>--%>
        <%--<th>Code</th>--%>
        <%--<th>Name</th>--%>
    <%--</tr>--%>
    <%--<c:forEach items="${problem.alternatives}" var="alternative" varStatus="status">--%>
        <%--<tr>--%>
            <%--<td>${alternative.code}</td>--%>
            <%--<td>${alternative.name}</td>--%>
        <%--</tr>--%>
    <%--</c:forEach>--%>
<%--</table>--%>

<%--<h3>Matrix of criteria comparison</h3>--%>
<%--<table>--%>
    <%--<tr>--%>
        <%--<td></td>--%>
        <%--<c:forEach items="${problem.factors}" var="factor" varStatus="status">--%>
            <%--<td><b>${factor.code}</b></td>--%>
        <%--</c:forEach>--%>
    <%--</tr>--%>
    <%--<c:forEach items="${problem.matrix}" var="row" varStatus="y_status">--%>
        <%--<tr>--%>
            <%--<td><b>${problem.factors.get(y_status.index).code}</b></td>--%>
            <%--<c:forEach items="${problem.matrix[y_status.index]}" var="cell" varStatus="x_status">--%>
                <%--<td>${cell}</td>--%>
            <%--</c:forEach>--%>
        <%--</tr>--%>
    <%--</c:forEach>--%>
<%--</table>--%>

<h3>Result:</h3>
<table>
    <tr>
        <td></td>
        <c:forEach items="${problem.factors}" var="factor" varStatus="status">
            <td>${factor.code}</td>
        </c:forEach>
    </tr>
    <tr>
        <td><i>Criteria Priority</i></td>
        <c:forEach items="${problem.getPrioritiesVector('FACTORS')}" var="priority">
            <td><i>${priority}</i></td>
        </c:forEach>
        <td><b>Global Priority</b></td>
    </tr>
    <c:forEach items="${problem.alternatives}" var="alternative" varStatus="y_status">
        <tr>
            <td>${alternative.code}</td>
            <c:forEach items="${problem.factors}" var="factor" varStatus="x_status">
                <td>${matrix[x_status.index][y_status.index]}</td>
            </c:forEach>
            <td><b>${globalPriorities[y_status.index]}</b></td>
        </tr>
    </c:forEach>
</table>
<%@ include file="parts/scripts.jsp" %>
</body>
</html>