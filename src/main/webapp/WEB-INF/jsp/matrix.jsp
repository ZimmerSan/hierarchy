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
<h2>Submitted Problem Information</h2>
<table>
    <tr>
        <td>Name :</td>
        <td>${problem.name}</td>
    </tr>
    <tr>
        <td>Factors Count :</td>
        <td>${problem.factorsCount}</td>
    </tr>
</table>

<h3>Submitted Factors Details</h3>
<table>
    <tr>
        <th>Code</th>
        <th>Name</th>
    </tr>
    <c:forEach items="${problem.factors}" var="factor" varStatus="status">
        <tr>
            <td>${factor.code}</td>
            <td>${factor.name}</td>
        </tr>
    </c:forEach>
</table>

<h3>Entered Alternatives</h3>
<table>
    <tr>
        <th>Code</th>
        <th>Name</th>
    </tr>
    <c:forEach items="${problem.alternatives}" var="alternative" varStatus="status">
        <tr>
            <td>${alternative.code}</td>
            <td>${alternative.name}</td>
        </tr>
    </c:forEach>
</table>

<h3>Enter Matrix</h3>
<form:form method="POST" action="enterMatrix" modelAttribute="problem">
    <table>
        <tr>
            <td></td>
            <c:forEach items="${problem.factors}" var="factor" varStatus="status">
                <td>${factor.code}</td>
            </c:forEach>
        </tr>
        <c:forEach items="${problem.matrix}" var="row" varStatus="y_status">
            <tr>
                <td>${problem.factors.get(y_status.index).code}</td>
                <c:forEach items="${problem.matrix[y_status.index]}" var="cell" varStatus="x_status">
                    <c:if test="${x_status.index > y_status.index}">
                        <td><form:input path="matrix[${y_status.index}]" value="${cell}"/></td>
                    </c:if>
                    <c:if test="${x_status.index == y_status.index}">
                        <td><form:input path="matrix[${y_status.index}]" value="1" readonly="true"/></td>
                    </c:if>
                    <c:if test="${x_status.index < y_status.index}">
                        <td><form:hidden path="matrix[${y_status.index}]" value="0" readonly="true"/></td>
                    </c:if>
                </c:forEach>
            </tr>
        </c:forEach>
    </table>
    <input type="submit" value="Save"/>
</form:form>
<%@ include file="parts/scripts.jsp" %>
</body>
</html>