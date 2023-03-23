<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- /springmvc2/src/main/webapp/WEB-INF/view/board/detail.jsp--%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>게시물 상세보기</title>
<script type="text/javascript"
src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js">
</script>
<style type="text/css">
  .leftcol {  text-align: left;	vertical-align : top;  }
  .lefttoptable {  height : 250px;	    border-width: 0px;
              text-align: left;	vertical-align : top;
              padding: 0px;
              width : 100%; }
  width: 50px;
  height: 50px;
  text-align: center;
  margin: 50px auto;
}
.tdeco {text-decoration: none;}
p {font-color:red;}

 #modal.modal-overlay {
    width: 100%;
    min-height: 100%;
    height: 2000px;
    position: absolute;
    left: 0;
    top: 0;
    display: none;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    background: rgba(255, 255, 255, 0.25);
    box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
    backdrop-filter: blur(1.5px);
    -webkit-backdrop-filter: blur(1.5px);
    border-radius: 10px;
    border: 1px solid rgba(255, 255, 255, 0.18);
    z-index:9999;
}
#modal .modal-window {
    background: rgba( 255, 109, 14, 0.80 );
    box-shadow: 0 8px 32px 0 rgba( 31, 38, 135, 0.37 );
    backdrop-filter: blur( 13.5px );
    -webkit-backdrop-filter: blur( 13.5px );
    border-radius: 10px;
    border: 1px solid rgba( 255, 255, 255, 0.18 );
    width: 400px;
    height: 350px;
    position: relative;
    padding: 30px;
    top: -100px;
    magin-left: 20px;
}
#modal .title {
    display: inline;
    text-shadow: 1px 1px 2px gray;
    color: white;
    
}
#modal .title h2 {
    display: inline;
    text-shadow: 1px 1px 2px gray;
    color: white;
}
#modal .close-area {
	border: 0;
	outline: 0;
    display: inline;
    float: right;
    cursor: pointer;
    text-shadow: 1px 1px 2px gray;
    color: white;
    background: rgba( 255, 255, 255, 0);
}

#modal .content {
    padding: 0px 60px 0px 0px;
    text-shadow: 1px 1px 2px gray;
    color: white;
}

#modal .contentbox {
	height: 150px;
	width: 300px;
    margin-top: 5px;
    padding: 0px 15px;
    color: black;
}

#modal .updatebtn{
	position: relative;
	top: 5px;
	left: 220px;
}
</style>
<script type="text/javascript">
function like(){
	$.ajax({
		url: "../ajax/detailLike",
    	type: "POST",
    	data:{
    		userid : "${sessionScope.loginUser.userid}",
    		num : ${board.bno}
    	},
    	async : false,
		success: function(data){ //http code: 200 => 202 201
			if(data != null)
				location.reload();
		}
	})
}
function addComment(){
	$.ajax({
		url: "../ajax/addComment",
    	type: "POST",
    	data:{
    		bno: ${board.bno},
    		userid : "${sessionScope.loginUser.userid}",
    		content: document.getElementById("content").value
    	},
		success: function(){ //http code: 200 => 202 201
			history.go(0);
		}
	})
}
function login_need(){
	alert("로그인 후 사용 가능합니다.")
}
function board_delete() {
	window.open("delete?num="+${board.bno},"delete","width=400, height=300");
}
//////////////////////////////////////////////////////////////////////////////////
function updateComment() {
	const modal = document.getElementById("contentbox")
	modalOff();
    const cnodom = document.getElementById("cno");
	$.ajax({
		url:"../ajax/updateComment",
		type:"POST",
		data:{
    		bno: ${board.bno},
    		userid : "${sessionScope.loginUser.userid}",
			cno :cnodom.value,
			content : contentbox.value
		},
		success:function(){
			history.go(0);	
			alert("수정 되었습니다.")
		},
		error:function(req,status,error){
        }
	})
}
function deleteComment(cno) {
	if(confirm("댓글을 삭제하시겠습니까?")){
		$.ajax({
			url:"../ajax/deleteComment",
			data:{"cno":cno},
			type:"POST",
			success:function(){
				history.go(0);	
				alert("삭제되었습니다.")
			},
			error:function(req,status,error){
            }
		})
	}
}
function modalOn(cno) {
	const modal = document.getElementById("modal");
    modal.style.display = "flex";
    const cnodom = document.getElementById("cno");
    cnodom.value = cno;
}
function isModalOn() {
	const modal = document.getElementById("modal");
    return modal.style.display === "flex";
}
function modalOff() {
	const modal = document.getElementById("modal");
    modal.style.display = "none";
}

const closeBtn = modal.querySelector(".close-area")
closeBtn.addEventListener("click", e => {
    modalOff();
})
</script>
</head>
<body>
<table class="w3-table-all">
<tr><td colspan="2">${boardName}</td><td>조회수</td><td>${board.readcnt}</td></tr>
   <tr><td width="15%">글쓴이</td><td width="50%" class="leftcol">${user.nickname}</td><td width="15%">최근 작성 및 수정</td>
   <td width="20%"><fmt:formatDate value="${board.regdate}" pattern="yyyy-MM-dd HH:mm:ss" /></td></tr>
   <tr><td>제목</td><td class="leftcol">${board.article}</td>
   	<td>좋아요&nbsp;&nbsp;(${board.heart}개)</td>
	<td>
  <c:if test="${sessionScope.loginUser==null || sessionScope.loginUser.equals('')}">
    <a href="javascript:login_need()"><img src="../images/cannotlike.png" width="30" height="30"></a>
  </c:if>
  <c:if test="${sessionScope.loginUser!=null && findLikes == 0}">
    <a href="javascript:like();"><img src="../images/like.png" width="30" height="30"></a>
  </c:if>
  <c:if test="${sessionScope.loginUser!=null && findLikes == 1}">
    <a href="javascript:like();"><img src="../images/dislike.png" width="30" height="30"></a>
  </c:if></td></tr>  
   <tr><td>주소</td><td colspan="3">${board.paddress}</td></tr>
   <tr><td>상호명</td><td>${board.pname}</td><td>전화번호</td><td>${board.phone}</td></tr>
   <tr><td>대표메뉴</td><td class="leftcol">${board.menu}</td><td>대표메뉴가격</td><td class="leftcol">${board.price}</td></tr>
   <tr><td>별점</td><td colspan="3" class="leftcol">${board.grade}점/10점</td></tr>
   <tr><td>내용 및 사진</td><td colspan="4" class="leftcol">
<table class="lefttoptable">
<tr><td><c:if test="${board.imgurl !=null}">
<a href="file/${board.imgurl}"><img src="file/${board.imgurl}" alt="사진"
     	 class="w3-hover-opacity" width="284" height="206"></a></c:if>
<c:if test="${board.imgurl ==null}">
<a href="../images/no_image.gif"><img src="../images/no_image.gif" alt="사진"
     	 class="w3-hover-opacity" width="284" height="206"></a></c:if></td>
<td  class="leftcol lefttoptable">${board.subsistence}</td></tr>
</table></td></tr>
<tr><td>지도정보</td><td colspan="4">
<div id="map" style="width:100%;height:240px;">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a8a1d695aec14a0b043d964924483a5"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(${board.map_a}, ${board.map_b}), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption);

// 마커가 표시될 위치입니다 
var markerPosition  = new kakao.maps.LatLng(${board.map_a}, ${board.map_b}); 

// 마커를 생성합니다
var marker = new kakao.maps.Marker({
    position: markerPosition
});

// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

var iwContent = '<div style="padding:5px;">${board.pname}<br><a href="https://map.kakao.com/link/map/${board.pname},${board.map_a},${board.map_b}" style="color:blue" target="_blank">큰지도보기</a> <a href="https://map.kakao.com/link/to/${board.pname},${board.map_a},${board.map_b}" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
    iwPosition = new kakao.maps.LatLng(${board.map_a}, ${board.map_a}); //인포윈도우 표시 위치입니다
    
// 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({
    position : iwPosition, 
    content : iwContent 
});
// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
infowindow.open(map, marker); 
</script>
</div>
</td></tr>
<tr><td colspan="5">   
     <c:if test="${board.userid == sessionScope.loginUser.userid}">
     <a href="update?num=${board.bno}">[수정]</a></c:if>
     <c:if test="${board.userid == sessionScope.loginUser.userid || sessionScope.loginUser.userid == 'admin' }">
     <a href="javascript:board_delete();">[삭제]</a></c:if>
     <a href="list?boardid=${boardid}">[게시물목록]</a></td></tr>
</table>
<div id="modal" class="modal-overlay">
   <div class="modal-window">
   <input type="hidden" id="cno" name="cno" value="">
       <div class="title">
           <h2>댓글 수정</h2>
       </div>
       <button class="close-area" onclick="javascript:modalOff()">X</button>
		<div class="content">
			<br>
				내용 : <textarea id="contentbox" class="contentbox" rows="10" cols="20" autofocus required></textarea>
			<br/>
		</div>
		<button class="updatebtn" style="left" onclick="javascript:updateComment()">수정하기</button>
   </div>
</div>
<!-- 댓글 출력 부분 시작 
 (리스트로 받아와서 넘기면 동작은 됨) -->
<table class="w3-table-all">
<tr><td width="15%">유저</td><td width="65%">댓글내용</td><td width="20%">작성시간</td>
<c:forEach items="${list}" var="comment">

<tr><td>${comment.nickname}</td>
<td>${comment.content }
	<c:if test="${comment.userid == sessionScope.loginUser.userid}">
		<a href="javascript:modalOn(${comment.cno})">[수정]</a>
	</c:if>
	<c:if test="${comment.userid == sessionScope.loginUser.userid || sessionScope.loginUser.userid == 'admin' }">
		<a href="javascript:deleteComment(${comment.cno})">[삭제]</a>
	</c:if></td>
<td><fmt:formatDate value="${comment.wdate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
</c:forEach>
</table>
<!-- 댓글 출력 부분 끝 -->
  <!-- 댓글 입력 부분 시작 (동작 안됨) -->
<hr>
<input type="hidden" name="bno" value="">
<table class="w3-table-all">
<tr><td><input type="text" name="writer" value="${sessionScope.loginUser.getNickname()}" readonly="true"></td></tr>
<tr><td><textarea style="width:100%" id="content"></textarea></td></tr>
<tr><td align="right"><button type="submit" onclick="javascript:addComment()">댓글 작성</button></td></tr>
</table>
<!-- 댓글 입력 부분 끝 -->
</body>
</html>