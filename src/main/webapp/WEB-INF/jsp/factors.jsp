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
                        <li class="breadcrumb-item active" aria-current="page">
                            <spring:message code="page.factors"/>
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
            <button class="btn btn-info"><span class="fui-folder"></span> <spring:message code="button.download"/></button>
        </div>
    </div>
    <h1 class="demo-panel-title"><spring:message code="problem.factors"/></h1>
    <form:form method="POST" action="enterFactors" modelAttribute="problem">
        <div class="row">
            <div class="col">
                <div class="form-group row">
                    <div class="col-1"></div>
                    <div class="col-2 text-right"><spring:message code="label.code"/></div>
                    <div class="col-8"><spring:message code="label.name"/></div>
                </div>
                <c:forEach items="${problem.factors}" var="factor" varStatus="status">
                    <div class="form-group row">
                        <form:hidden path="factors[${status.index}].code" value="${factor.code}" readonly="true"/>
                        <div class="col-1"></div>
                        <div class="col-2 text-right">${factor.code}</div>
                        <div class="col-7">
                            <form:input path="factors[${status.index}].name" value="${factor.name}" class="form-control"/>
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
<%@ include file="parts/scripts.jsp" %>
</body>
</html>