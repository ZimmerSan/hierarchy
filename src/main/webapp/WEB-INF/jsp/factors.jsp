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

<h3>Enter Factors Details</h3>
<form:form method="POST" action="enterFactors" modelAttribute="problem">
    <table>
        <tr>
            <th>Code</th>
            <th>Name</th>
        </tr>
        <c:forEach items="${problem.factors}" var="factor" varStatus="status">
            <tr>
                <form:hidden path="factors[${status.index}].code" value="${factor.code}" readonly="true"/>
                <td>${factor.code}</td>
                <td><form:input path="factors[${status.index}].name" value="${factor.name}"/></td>
            </tr>
        </c:forEach>
    </table>
    <input type="submit" value="Save" />
</form:form>
<%@ include file="parts/scripts.jsp" %>
</body>
</html>