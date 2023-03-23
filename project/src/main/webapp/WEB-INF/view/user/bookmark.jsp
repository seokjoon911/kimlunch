<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style>
	.tdeco {text-decoration: none;
			font-size:18px;}
	p {width:100%;}
	.color {background-color : #FAD02C;}
</style>
<meta charset="UTF-8">
<title>좋아요 한 게시글</title>
</head>
<body>
<div class="w3-main w3-content w3-padding" style="max-width:1200px;margin-top:100px">
  <div class="w3-row-padding w3-padding-16 w3-center" id="food"> </div>
  <div class="w3-center w3-section w3-bottombar w3-padding-16">
      <h2>좋아요 한 게시글</h2> </div>
<div class="w3-container" style="margin-top:50px">
   <table style="margin:auto"><tr><td>
		    <a href="${path}../board/list?boardid=1" class="w3-btn color" style="border-radius:10px 10px 10px 10px;">일반 게시판</a>
		    <a href="${path}../board/list?boardid=2" class="w3-btn color" style="border-radius:10px 10px 10px 10px;">인기 게시판</a>
		    <a href="${path}../board/list?boardid=3" class="w3-btn color" style="border-radius:10px 10px 10px 10px;">한식</a>
		    <a href="${path}../board/list?boardid=4" class="w3-btn color" style="border-radius:10px 10px 10px 10px;">일식</a>
		    <a href="${path}../board/list?boardid=5" class="w3-btn color" style="border-radius:10px 10px 10px 10px;">중식</a>
		    <a href="${path}../board/list?boardid=6" class="w3-btn color" style="border-radius:10px 10px 10px 10px;">양식</a>
		    <a href="${path}../board/list?boardid=7" class="w3-btn color" style="border-radius:10px 10px 10px 10px;">분식</a>
		    <a href="${path}../board/list?boardid=8" class="w3-btn color" style="border-radius:10px 10px 10px 10px;">아시안 푸드</a>
  	</td></tr></table>
      <div class="w3-main w3-content w3-padding-" style="max-width:1200px;margin-top:10px">
  <div class="w3-row-padding w3-padding-16 w3-center" id="food"></div>
  	</div>
</div> 
</div>
 <div class="w3-container">
<c:if test="${mylikescount > 0}"><tr>
	<c:forEach var="b_board" items="${getlist}" varStatus="stat"><td>
 		<c:if test='${stat.index % 4==0}' />
 		<div class="w3-quarter w3-center" >
    	<a href="../board/detail?num=${b_board.bno}" class="tdeco" >
    	<c:if test="${b_board.imgurl !=null}">
    		<img src="../board/file/${b_board.imgurl}" alt="사진" 
     	 class="w3-hover-opacity w3-container" style="width:100%" height="276"><br><br><b>${b_board.article}</b><br><br><br></c:if>
     	 <c:if test="${b_board.imgurl == null}">
    		<img src="../images/no_image.gif" alt="사진" 
     	 class="w3-hover-opacity w3-container" style="width:100%" height="276"><br><br><b>${b_board.article}</b><br><br><br></c:if></a>
     </div>
     <c:if test='${stat.index % 4==3}' />
    </td></c:forEach></tr></c:if>
<c:if test="${mylikescount == 0}">
	<div><table style="margin:auto;"><tr align="center"><td>등록된 게시물이 없습니다.</td></tr></table></div>
	</c:if> 
</div>
   <div class="w3-center w3-padding-32">
   <table style="margin:auto; width:100%" >
   <tr align="center"><td colspan="5">
    <div class="w3-bar w3-center">
     <c:if test="${pageNum > 1}">
       <a href="myboard?pageNum=${pageNum -1}">[이전]</a></c:if>
       <c:if test="${pageNum <= 1}">[이전]</c:if>
     <c:forEach var="a" begin="${startpage }" end="${endpage}">
         <c:if test="${a == pageNum}"><a class="w3-button w3-black" href="#">${a}</a></c:if>
         <c:if test="${a != pageNum}">
           <a class="w3-button w3-hover-black" 
              href="myboard?pageNum=${a}">${a}</a></c:if>
     </c:forEach>
     <c:if test="${pageNum < maxpage}">
           <a href="myboard?pageNum=${pageNum + 1}">[다음]</a></c:if>
     <c:if test="${pageNum >= maxpage}">[다음]</c:if>
     <c:if test="${!empty sessionScope.loginUser.userid}">
     <td align="right" width="1px">
     <a class="w3-button w3-hover-black" href="../board/list?boardid=1">글쓰기</a></td></c:if>
  
<c:if test="${listcount == 0}">
     <tr><td colspan="5">등록된 게시물이 없습니다.</td></tr></c:if>
</div>
</td></tr>      
</table>
</div>
</body>
</html>