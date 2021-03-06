<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/widget" prefix="widget"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Todooz</title>
<c:set var="contextPath"
	value="${pageContext.servletContext.contextPath}" scope="page" />


<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- Bootstrap -->
<link href="${contextPath}/bootstrap-3.3.4-dist/css/bootstrap.min.css"
	rel="stylesheet" media="screen">

<style type="text/css">
body {
	margin: 5px 0 50px 0;
}
</style>
</head>
<body>
	<div class="container">
		<widget:navbar />
		<c:if test="${not empty flashMessage}">
			<div class="alert alert-success">${flashMessage}</div>
		</c:if>
		<div class="row">
			<div class="col-lg-9">
				<sec:authorize access="hasRole('ROLE_USER')">
					<div>
						<legend>
							Add new Task<a href="${contextPath}/add"
								class="btn btn-default navbar-btn" style="margin-left: 10px">
								<span class="glyphicon glyphicon-plus"></span>
							</a>
						</legend>
					</div>
				</sec:authorize>

				<div>
					<legend>All tasks</legend>
					<table class="table table-hover table-responsive">
						<thead>
							<th>Title</th>
							<th>Date</th>
							<th>Description</th>
							<th>Tags</th>
							<th>Admin</th>
						</thead>
						<tbody>
							<c:forEach var="task" items="${tasks}">
								<widget:task task="${task}" />
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>

			<div class="col-lg-3">
				<div class="panel panel-default">
					<div class="panel-heading">Bienvenue</div>
					<div class="panel-body">
						<sec:authorize access="hasRole('ROLE_USER')">
							<!-- For login user -->
							<c:url value="/j_spring_security_logout" var="logoutUrl" />
							<form action="${logoutUrl}" method="post" id="logoutForm">
								<!-- TODO: Reactiver le controle csrf 
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								-->
							</form>
							<script>
								function formSubmit() {
									document.getElementById("logoutForm")
											.submit();
								}
							</script>

							<c:if test="${pageContext.request.userPrincipal.name != null}">
								<h5>
									<div>Bienvenue ${pageContext.request.userPrincipal.name}
									</div>

								</h5>
							</c:if>
							<div>
								Logout <a href="javascript:formSubmit()"> <span
									class="glyphicon glyphicon-off" aria-hidden="true"></span>
								</a>
							</div>


						</sec:authorize>

						<sec:authorize access="isAnonymous()">
							<div>
								Login <a href="${contextPath}/login"><span
									class="glyphicon glyphicon-user" aria-hidden="true"></span></a>
							</div>
						</sec:authorize>
					</div>
				</div>
				
				<sec:authorize access="!isAnonymous()">
					<div class="panel panel-default">
						<div class="panel-heading">GED</div>
						<div class="panel-body">
							<ul>
								<sec:authorize access="hasRole('ROLE_ADMIN')">
									<li><a href="${contextPath}/fileManage/uploadInvite">Upload</a></li>
								</sec:authorize>
								<sec:authorize access="hasRole('ROLE_USER')">
									<li><a href="${contextPath}/fileManage/upload">Download</a></li>
								</sec:authorize>
							</ul>
						</div>
					</div>
				</sec:authorize>
				
				

				<div class="panel panel-default">
					<div class="panel-heading">Quick links</div>
					<div class="panel-body">
						<ul>
							<li><a href="${contextPath}/deadLine/today">Today's</a></li>
							<li><a href="${contextPath}/deadLine/tomorrow">Tomorrow's</a></li>
						</ul>
					</div>
				</div>

				<div class="panel panel-default">
					<div class="panel-heading">Tags</div>
					<div class="panel-body">
						<c:forEach var="tag" items="${tagCloud.tags}">
							<a href="${contextPath}/tag/${tag}" style="font-size: 14px"><c:out
									value="${tag}" /></a>
						</c:forEach>
					</div>
				</div>
				<div class="panel panel-default">
					<div class="panel-heading">Products</div>
					<div class="panel-body">
						<a href="${contextPath}/backlog" style="font-size: 14px">Backlog</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="${contextPath}/jquery/jquery-2.1.4.js"></script>
	<script src="${contextPath}/bootstrap-3.3.4-dist/js/bootstrap.min.js"></script>
	<script>
	
	var warnDelete = function() {
		$("a[name='taskDelete']").on("click", function(event){
				if (confirm("Yes, delete this task.") == true) {
					//Nothing to do.
				} else {
					event.preventDefault();
				}
			}
				
		);
	};
		
		$(function(){
			warnDelete();
		});
		
	</script>
</body>
</html>