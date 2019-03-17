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

<h3>Enter Alternatives</h3>
<form:form method="POST" action="enterAlternatives" modelAttribute="problem">
    <table>
        <tr>
            <th>Code</th>
            <th>Name</th>
        </tr>
        <c:forEach items="${problem.alternatives}" var="alternative" varStatus="status">
            <tr>
                <form:hidden path="alternatives[${status.index}].code" value="${alternative.code}" readonly="true"/>
                <td>${alternative.code}</td>
                <td><form:input path="alternatives[${status.index}].name" value="${alternative.name}"/></td>
            </tr>
        </c:forEach>
    </table>
    <input type="submit" value="Save" />
</form:form>
<%@ include file="parts/scripts.jsp" %>
</body>
</html>