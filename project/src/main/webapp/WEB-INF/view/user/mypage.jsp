<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<style>
	.tdeco {text-decoration: none;}
	p {width:100%;}
</style>
<meta charset="UTF-8">
<title>My page</title>
<body class="w3-light-grey">

<!-- Page Container -->
<div class="w3-content w3-margin-top" style="max-width:1400px;">

  <!-- The Grid -->
  <div class="w3-row-padding">
  
    <!-- Left Column -->
    <div class="w3-third">
    
      <div class="w3-white w3-text-grey w3-card-4">
        <div class="w3-container">
        <br><br>
        <table class="w3-table">
		<tr><td>이름</td><td>${user.name}</td></tr>
		<tr><td>닉네임</td><td>${user.nickname}</td></tr>
		<tr><td>아이디</td><td>${user.userid}</td></tr>
		<tr><td>연락처</td><td>${user.phoneno}</td></tr>
		<tr><td>이메일</td><td>${user.email}</td></tr>
		<tr><td>성별</td><td><c:if test="${user.gender==1}" >남</c:if>
			<c:if test="${user.gender==2}" >여</c:if>
			<c:if test="${user.gender==3}" >기타</c:if></tr>
		<tr><td>직장</td><td>${user.address}</td></tr>
		<tr><td><a href="update?userid=${user.userid}">정보수정</a></td></tr>
		<tr><td><a href="password?userid=${user.userid}">비밀번호수정</a></td></tr>
		<tr><td><a href="delete?userid=${user.userid}">회원탈퇴</a></td></tr>
		</table><br>
          <hr>
          <br>
        </div>
      </div><br>

    <!-- End Left Column -->
    </div>

    <!-- Right Column -->    
    <div class="w3-twothird">
      <div class="w3-container w3-card w3-white w3-margin-bottom">
        <a href="myboard?userid=${sessionScope.loginUser.userid}"><h2 class="w3-text-black w3-padding-16">내가 쓴 글</h2></a>
       	  <c:forEach var="b_board" items="${myboardlist}"><tr><td>
       	  	<c:if test="${b_board.boardid==1}" >일반게시판</c:if>
			<c:if test="${b_board.boardid==2}" >인기게시판</c:if>
			<c:if test="${b_board.boardid==3}" >한식</c:if>
			<c:if test="${b_board.boardid==4}" >일식</c:if>
			<c:if test="${b_board.boardid==5}" >중식</c:if>
			<c:if test="${b_board.boardid==6}" >양식</c:if>
			<c:if test="${b_board.boardid==7}" >분식</c:if>
			<c:if test="${b_board.boardid==8}" >아시안 푸드</c:if>
    		<a href="../board/detail?num=${b_board.bno}" class="tdeco">
    		<b>${b_board.article}</b><br></a>
 			</td></tr></c:forEach><br><br> 
      </div>
      <div class="w3-twothird">
      <div class="w3-container w3-card w3-white w3-margin-bottom">
        <a href="bookmark?userid=${sessionScope.loginUser.userid}"><h2 class="w3-text-black w3-padding-16">좋아요 한 글</h2></a>
       	  <c:forEach var="b_board" items="${getlist}"><tr><td>
       	  	<c:if test="${b_board.boardid==1}" >일반게시판</c:if>
			<c:if test="${b_board.boardid==2}" >인기게시판</c:if>
			<c:if test="${b_board.boardid==3}" >한식</c:if>
			<c:if test="${b_board.boardid==4}" >일식</c:if>
			<c:if test="${b_board.boardid==5}" >중식</c:if>
			<c:if test="${b_board.boardid==6}" >양식</c:if>
			<c:if test="${b_board.boardid==7}" >분식</c:if>
			<c:if test="${b_board.boardid==8}" >아시안 푸드</c:if>
    		<a href="../board/detail?num=${b_board.bno}" class="tdeco">
    		<b>${b_board.article}</b><br></a>
 			</td></tr></c:forEach><br><br> 
      </div>
    <!-- End Right Column -->
    </div>
    
  <!-- End Grid -->
  </div>
  
  <!-- End Page Container -->
</div>

</body>