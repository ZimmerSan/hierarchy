<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="parts/meta.jsp" %>
    <%@ include file="parts/head.jsp" %>

    <title>Hello boy!</title>
</head>
<body>
<div class="container">
    <div class="demo-headline">
        <div class="row">
            <div class="col">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="<c:url value="/"/>"><spring:message code="page.start"/></a>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="<c:url value="/enterFactors"/>"><spring:message code="page.factors"/></a>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="<c:url value="/enterAlternatives"/>"><spring:message code="page.alternatives"/></a>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="<c:url value="/enterMatrix"/>"><spring:message code="page.matrix"/></a>
                        </li>
                        <li class="breadcrumb-item active" aria-current="page">
                            <spring:message code="page.factormatrices"/>
                        </li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-10">
            <h1 class="demo-section-title"><spring:message code="problem.details.enter.header"/></h1>
        </div>
        <div class="col-2 text-right">
            <form:form method="POST" action="saveInfoToFile" modelAttribute="form">
            	<button class="btn btn-info"><span class="fui-folder"></span> <spring:message code="button.download"/></button>
            </form:form>
        </div>
    </div>
    <h1 class="demo-panel-title"><spring:message code="problem.alternative.priorities.matrix"/> <spring:message
            code="for"/> <i>${factor.name} (${factor.code})</i></h1>
    <div class="row">
        <div class="col">
            <form:form method="POST" action="enterFactorMatrices" modelAttribute="form">
                <form:hidden path="key"/>
                <div class="form-group row">
                    <div class="col-12">
                        <table class="matrix">
                            <tr>
                                <td class="font-italic font-weight-bold">${factor.code}</td>
                                <c:forEach items="${problem.alternatives}" var="alternative">
                                    <td>${alternative.name}</td>
                                </c:forEach>
                            </tr>
                            <c:forEach items="${form.matrix}" var="row" varStatus="y_status">
                                <tr>
                                    <td>${problem.alternatives.get(y_status.index).name}</td>
                                    <c:forEach items="${form.matrix[y_status.index]}" var="cell" varStatus="x_status">
                                        <c:if test="${x_status.index > y_status.index}">
                                            <td><form:input path="matrix[${y_status.index}]" value="${cell}" cssClass="form-control"/></td>
                                        </c:if>
                                        <c:if test="${x_status.index == y_status.index}">
                                            <td><form:input path="matrix[${y_status.index}]" value="1"
                                                            readonly="true" cssClass="form-control"/></td>
                                        </c:if>
                                        <c:if test="${x_status.index < y_status.index}">
                                            <td><form:hidden path="matrix[${y_status.index}]" value="0"
                                                             readonly="true"/></td>
                                        </c:if>
                                    </c:forEach>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                </div>
                <div class="row form-group">
                    <div class="col-12 text-center">
                        <input type="submit" class="btn btn-primary" value="Submit"/>
                    </div>
                </div>
            </form:form>

        </div>
    </div>

    <br/>

    <h1 class="demo-section-title"><spring:message code="problem.details.submitted.header"/></h1>
    <div class="row">
        <div class="col-4">
            <h1 class="demo-panel-title"><spring:message code="problem.data.basic"/></h1>
            <div class="row">
                <div class="col">
                    <span class="font-italic"><b><spring:message code="problem.name"/>:</b> ${problem.name}</span>
                </div>
            </div>
            <div class="row">
                <div class="col">
            <span class="font-italic"><b><spring:message
                    code="problem.factorsCount"/>:</b> ${problem.factorsCount}</span>
                </div>
            </div>
            <div class="row">
                <div class="col">
            <span class="font-italic"><b><spring:message
                    code="problem.alternativesCount"/>:</b> ${problem.alternativesCount}</span>
                </div>
            </div>
        </div>
        <div class="col-4">
            <h1 class="demo-panel-title"><spring:message code="problem.factors"/></h1>
            <c:forEach items="${problem.factors}" var="factor" varStatus="status">
                <div class="row">
                    <div class="col-2 font-italic"><b>${factor.code}:</b></div>
                    <div class="col-10">${factor.name}</div>
                </div>
            </c:forEach>
        </div>
        <div class="col-4">
            <h1 class="demo-panel-title"><spring:message code="problem.alternatives"/></h1>
            <c:forEach items="${problem.alternatives}" var="alternative" varStatus="status">
                <div class="row">
                    <div class="col-2 font-italic"><b>${alternative.code}:</b></div>
                    <div class="col-10">${alternative.name}</div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<%@ include file="parts/scripts.jsp" %>
</body>
</html>