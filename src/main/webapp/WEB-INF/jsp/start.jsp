<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
        <h1 class="demo-logo">
            <spring:message code="program.title"/>
            <small><spring:message code="program.description"/></small>
        </h1>
    </div> <!-- /demo-headline -->

    <div class="row">
        <div class="col-10">
            <h1 class="demo-section-title"><spring:message code="problem.details.enter.header"/></h1>
        </div>
        <div class="col-2 text-right">
            <button class="btn btn-success"><span class="fui-clip"></span> <spring:message code="button.upload"/></button>
        </div>
    </div>
    <h1 class="demo-panel-title"><spring:message code="problem.data.basic"/></h1>

    <form:form method="POST" action="/" modelAttribute="problem">
        <div class="form-group row">
            <div class="col-6">
                <div class="form-group">
                    <p><spring:message code="problem.name"/>:</p>
                    <form:input path="name" class="form-control"/>
                </div>
            </div>
            <div class="col-3">
                <div class="form-group">
                    <p><spring:message code="problem.factorsCount"/>:</p>
                    <form:input path="factorsCount" class="form-control"/>
                </div>
            </div>
            <div class="col-3">
                <div class="form-group">
                    <p><spring:message code="problem.alternativesCount"/>:</p>
                    <form:input path="alternativesCount" class="form-control"/>
                </div>
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
</div>
<%@ include file="parts/scripts.jsp" %>
</body>
</html>