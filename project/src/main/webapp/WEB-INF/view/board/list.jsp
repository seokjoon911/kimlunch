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
<title>게시판</title>
</head>
<body>
<script type="text/javascript"
src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js">
</script>
<script type="text/javascript">
function search(){
	$.ajax({
		url: "../board/search",
    	type: "GET",
    	data:{
    		find:   document.getElementById("find").value,
    		column: document.getElementById("column").value
    	},
		success: function(){ //http code: 200 => 202 201
			location.replace("../board/search?column="+document.getElementById("column").value+"&find="+document.getElementById("find").value);
		}
	})
}
</script>
 <div class="w3-center w3-padding-16">
 	
 	<select class="form-control" name="column" id="column">
        <option value="article">제목</option>
        <option value="subsistence">내용</option>
        <option value="paddress">주소</option>
    </select>
 
	 <input type="text" class="w3-btn w3-white w3-border w3-border-red w3-round-large" placeholder="검색어를 입력하세요"
	 style="width:400px; padding:10px; text-align:center" id="find"/>
	 <button type="submit" class="w3-btn w3-white w3-border w3-border-red w3-round-large"
	 onclick="javascript:search()">검색</button>
 </div>
<div class="w3-main w3-content w3-padding-" style="max-width:1200px;margin-top:100px">
   <div class="w3-container" style="margin-top:3px">
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
  	</div>
   <br><br><hr>
</div>
 <div class="w3-container">
 <c:if test="${listcount > 0}"><tr>
	<c:forEach var="b_board" items="${boardlist}" varStatus="stat"><td>
 		<c:if test='${stat.index % 4==0}' />
 		<div class="w3-quarter w3-center" >
    	<a href="detail?num=${b_board.bno}" class="tdeco" >
    	<c:if test="${b_board.imgurl !=null}">
    		<img src="file/${b_board.imgurl}" alt="사진" 
     	 class="w3-hover-opacity w3-container" style="width:100%" height="276"><br><br><b>${b_board.article}</b><br><br><br></c:if>
     	 <c:if test="${b_board.imgurl == null}">
    		<img src="../images/no_image.gif" alt="사진" 
     	 class="w3-hover-opacity w3-container" style="width:100%" height="276"><br><br><b>${b_board.article}</b><br><br><br></c:if></a>
     </div>
     <c:if test='${stat.index % 4==3}' />
    </td></c:forEach></tr></c:if>
<c:if test="${listcount == 0}">
	<div><table style="margin:auto;"><tr align="center"><td>등록된 게시물이 없습니다.</td></tr></table></div>
	</c:if> 
</div>

 <%-- 페이징 부분 --%>
<div class="w3-padding-32">
<table style="margin:auto; width:100%" >
 <tr align="center"><td colspan="5">
    <div class="w3-bar">
     <c:if test="${pageNum > 1}">
       <a href="list?pageNum=${pageNum - 1}&boardid=${boardid}">[이전]</a></c:if>
       <c:if test="${pageNum <= 1}">[이전]</c:if>
     <c:forEach var="a" begin="${startpage }" end="${endpage}">
         <c:if test="${a == pageNum}"><a class="w3-button w3-black" href="#">${a}</a></c:if>
         <c:if test="${a != pageNum}">
           <a class="w3-button w3-hover-black" 
              href="list?pageNum=${a}&boardid=${boardid}">${a}</a></c:if>
     </c:forEach>
     <c:if test="${pageNum < maxpage}">
           <a href="list?pageNum=${pageNum + 1}&boardid=${boardid}">[다음]</a></c:if>
     <c:if test="${pageNum >= maxpage}">[다음]</c:if>
     <c:if test="${!empty sessionScope.loginUser.userid}">
     </td></c:if>
     </div>
     
<c:if test="${!empty param.boardid || param.boardid == '1'}">
 <tr><td align="right"><a class="w3-button w3-hover-black" href="write">[글쓰기]</a></td></tr>
 </c:if>        
     
</td></tr>    
</table>  
 </div>
</body>
</html>