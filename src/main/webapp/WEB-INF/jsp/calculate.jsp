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
                <h1 class="demo-logo">
                    <spring:message code="problem.solved"/>
                    <small>${problem.name}</small>
                </h1>
            </div>
        </div>
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
                        <c:forEach items="${problem.factors}" var="factor" varStatus="status">
                            <li class="breadcrumb-item">
                                <a href="<c:url value="/enterFactorMatrices?factor=${factor.code}"/>">${factor.code}</a>
                            </li>
                        </c:forEach>
                        <li class="breadcrumb-item active" aria-current="page">
                            <spring:message code="page.calculate"/>
                        </li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>

    <h1 class="demo-section-title"><spring:message code="problem.result.header"/></h1>
    <div class="row">
        <div class="col">
            <table class="matrix">
                <tr>
                    <td></td>
                    <c:forEach items="${problem.factors}" var="factor" varStatus="status">
                        <td class="text-center font-italic font-weight-bold">${factor.name}</td>
                    </c:forEach>
                </tr>
                <tr>
                    <td class="font-italic text-danger"><i>Criteria Priority</i></td>
                    <c:forEach items="${problem.getPrioritiesVector('FACTORS')}" var="priority">
                        <td class="font-italic text-danger">${priority}</td>
                    </c:forEach>
                    <td class="text-primary font-weight-bold">Global Priority</td>
                </tr>
                <c:forEach items="${problem.alternatives}" var="alternative" varStatus="y_status">
                    <tr>
                        <td class="font-italic font-weight-bold">${alternative.name}</td>
                        <c:forEach items="${problem.factors}" var="factor" varStatus="x_status">
                            <td>${matrix[x_status.index][y_status.index]}</td>
                        </c:forEach>
                        <td class="text-primary font-weight-bold">${globalPriorities[y_status.index]}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>

    <br/>

    <div class="row">
        <div class="col-10">
            <h1 class="demo-section-title"><spring:message code="problem.details.submitted.header"/></h1>
        </div>
        <div class="col-2 text-right">
            <button class="btn btn-info"><span class="fui-folder"></span> <spring:message code="button.download"/></button>
        </div>
    </div>
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