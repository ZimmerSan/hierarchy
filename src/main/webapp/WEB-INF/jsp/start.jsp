<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="parts/meta.jsp" %>
    <%@ include file="parts/head.jsp" %>

    <title>Hello boy!</title>
</head>
<body>
<div class="container">
    <div class="text-center">
            <h3>Enter The Problem Details</h3>

            <form:form method="POST" action="/" modelAttribute="problem">
                <table>
                    <tr>
                        <td><form:label path="name">Name</form:label></td>
                        <td><form:input path="name" class="form-control"/></td>
                    </tr>
                    <tr>
                        <td><form:label path="factorsCount">Number of factors</form:label></td>
                        <td><form:input path="factorsCount" class="form-control"/></td>
                    </tr>
                    <tr>
                        <td><form:label path="alternativesCount">Number of alternatives</form:label></td>
                        <td><form:input path="alternativesCount" class="form-control"/></td>
                    </tr>
                    <tr>
                        <td><input type="submit" class="btn btn-primary" value="Submit"/></td>
                    </tr>
                </table>
            </form:form>
        </span>
    </div>

    <%--<h3>Enter The Problem Details</h3>--%>
    <%--<form:form method="POST" action="/" modelAttribute="problem">--%>
        <%--<table>--%>
            <%--<tr>--%>
                <%--<td><form:label path="name">Name</form:label></td>--%>
                <%--<td><form:input path="name"/></td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<td><form:label path="factorsCount">Number of factors</form:label></td>--%>
                <%--<td><form:input path="factorsCount"/></td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<td><input type="submit" value="Submit"/></td>--%>
            <%--</tr>--%>
        <%--</table>--%>
    <%--</form:form>--%>
    </div>
</div>
<%@ include file="parts/scripts.jsp" %>
</body>
</html>