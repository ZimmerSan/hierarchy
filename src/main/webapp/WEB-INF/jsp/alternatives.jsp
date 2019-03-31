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
                        <li class="breadcrumb-item active" aria-current="page">
                            <spring:message code="page.alternatives"/>
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
    <h1 class="demo-panel-title"><spring:message code="problem.alternatives"/></h1>
    <form:form method="POST" action="enterAlternatives" modelAttribute="problem">
        <div class="row">
            <div class="col">
                <div class="form-group row">
                    <div class="col-1"></div>
                    <div class="col-2 text-right"><spring:message code="label.code"/></div>
                    <div class="col-8"><spring:message code="label.name"/></div>
                </div>
                <c:forEach items="${problem.alternatives}" var="alternative" varStatus="status">
                    <div class="form-group row">
                        <form:hidden path="alternatives[${status.index}].code" value="${alternative.code}" readonly="true"/>
                        <div class="col-1"></div>
                        <div class="col-2 text-right">${alternative.code}</div>
                        <div class="col-7">
                            <form:input path="alternatives[${status.index}].name" value="${alternative.name}" class="form-control"/>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <div class="row">
            <div class="col-12 text-center">
                <div class="form-group">
                    <input type="submit" class="btn btn-primary" value="Submit"/>
                </div>
            </div>
        </div>
    </form:form>

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
    </div>
</div>
<%@ include file="parts/scripts.jsp" %>
</body>
</html>