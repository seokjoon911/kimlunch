<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%--/springmvc1/src/main/webapp/layout/kiclayout.jsp --%>

<!DOCTYPE html>
<html>
<head>
<title><sitemesh:write property="title" /></title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Karma">
<style>
body,h1,h2,h3,h4,h5,h6 {font-family: "Karma", sans-serif}
.w3-bar-block .w3-bar-item {padding:20px}
.logo{
	width: 690px;
    height: 90px;
	background-image:url(../css/logotest.png);
	background-size:cover;
	background-repeat: no-repeat;
    background-position: center;
    border:none;
}

header {
  position: relative;
  height: 100px;
  align-items: center;
  padding-right: 30px;
}
.w3-button{
	padding-left: 50px
}

footer{
  height: 50px;
  position : relative;
  transform : translateY(-100%);
}
</style>
<sitemesh:write property="head" />
</head>
<body>
<!-- Top menu -->
<header>
  <span class="w3-bar-item w3-right">
	<c:if test="${empty sessionScope.loginUser}">
	 <a class="w3-right w3-padding-16" style="margin-left:30px; "href="${path}/user/join">회원가입</a>
	 <a class="w3-right w3-padding-16" href="${path}/user/login">로그인</a>
	</c:if>   
	<c:if test="${!empty sessionScope.loginUser}">
	<a href="${path}/user/mypage?userid=${sessionScope.loginUser.userid}">${sessionScope.loginUser.name}</a>님이 로그인 하셨습니다.&nbsp;&nbsp;
	 <a href="${path}/user/logout">로그아웃</a>
	</c:if> 
	<c:if test="${loginUser.userid == 'admin'}">
 		<a href="../admin/list">[회원목록]</a>&nbsp;
	</c:if>  
  </span>
  <div style="padding-top:40px;"/>
  <div class="w3-padding-16 w3-center">
	<button class="logo" onclick="location.href='../user/main'"></button>
</div>

</header>

<!-- !PAGE CONTENT! -->
<div class="w3-main w3-content w3-padding" style="max-width:100%; height: auto; margin-top: 50px; min-height: 100%; margin-bottom: 50px;">
  <sitemesh:write property="body" /> 
  </div>
  

<footer>
	<div class="w3-padding-16 w3-center">
	<hr style="width:100%">
		<p>Copyright@2022 All rights reserved | 맛집은 무조건 김런치!</p>
		<p>고객센터: 010-0000-0000</p>
	</div>
</footer>
</body>
</html>