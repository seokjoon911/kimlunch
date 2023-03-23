<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 작성</title>
   <style>
.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
.map_wrap {position:relative;width:100%;height:500px;}
#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
.bg_white {background:#fff;}
#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
#menu_wrap .option{text-align: center;}
#menu_wrap .option p {margin:10px 0;}  
#menu_wrap .option button {margin-left:5px;}
#placesList li {list-style: none;}
#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
#placesList .item span {display: block;margin-top:4px;}
#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
#placesList .item .info{padding:10px 0 10px 55px;}
#placesList .info .gray {color:#8a8a8a;}
#placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
#placesList .info .tel {color:#009900;}
#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
#placesList .item .marker_1 {background-position: 0 -10px;}
#placesList .item .marker_2 {background-position: 0 -56px;}
#placesList .item .marker_3 {background-position: 0 -102px}
#placesList .item .marker_4 {background-position: 0 -148px;}
#placesList .item .marker_5 {background-position: 0 -194px;}
#placesList .item .marker_6 {background-position: 0 -240px;}
#placesList .item .marker_7 {background-position: 0 -286px;}
#placesList .item .marker_8 {background-position: 0 -332px;}
#placesList .item .marker_9 {background-position: 0 -378px;}
#placesList .item .marker_10 {background-position: 0 -423px;}
#placesList .item .marker_11 {background-position: 0 -470px;}
#placesList .item .marker_12 {background-position: 0 -516px;}
#placesList .item .marker_13 {background-position: 0 -562px;}
#placesList .item .marker_14 {background-position: 0 -608px;}
#placesList .item .marker_15 {background-position: 0 -654px;}
#pagination {margin:10px auto;text-align: center;}
#pagination a {display:inline-block;margin-right:10px;}
#pagination .on {font-weight: bold; cursor: default;color:#777;}
</style>
</head>
<body>
<%--<form:form : html 태그의 form 태그 , 유효성 검증을 위한 form 설정
modelAttribute="user" : join.jsp 페이지가 실행될때 User객체 필요
 --%>
<form:form modelAttribute="board" method="post" action="write"
	enctype="multipart/form-data">

<%-- 오류 메세지의 코드에 해당하는 메세지 출력 --%>
<spring:hasBindErrors name="board">
<font color="red">

<%--errors.globalErrors: Controller에서 BindingResult객체에서 reject() 메서드로 설정한 코드값들 --%>
	<c:forEach items="${errors.globalErrors}" var="error">
		<spring:message code="${error.code}"/>
	</c:forEach>
</font>
</spring:hasBindErrors>
<table border="1" style="border-collapse: collapse;" class="w3-table">
<form:hidden path="userid" value="${sessionScope.loginUser.userid}"/>
<tr>
	<td>제목</td>
	<td><form:input path="article" class="w3-input" />
		<font color="red"><form:errors path="article" /></font></td>
</tr>
<tr>
	<td>내용</td>
	<td><form:input path="subsistence" class="w3-input" />
		<font color="red"><form:errors path="subsistence" /></font></td>
</tr>
<tr>
	<td>이미지</td>
	<td><input type="file" name="img">
	</td>
</tr>
<tr>
	<td>게시판위치</td>
	<td><select name="boardid">
			<option value="3">한식</option>
			<option value="4">일식</option>
			<option value="5">중식</option>
			<option value="6">양식</option>
			<option value="7">분식</option>
			<option value="8">아시안푸드</option>
</select></td>
</tr>
<tr>
	<td>가격</td>
	<td><form:input path="price" class="w3-input" />
	<font color="red"><form:errors path="price" /></font></td>
</tr>
<tr>
	<td>메뉴</td>
	<td><form:input path="menu" class="w3-input" />
	<font color="red"><form:errors path="menu" /></font></td>
</tr>
<tr>
	<td>별점</td>
	<td><select name="grade">
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
			<option value="5">5</option>
			<option value="6">6</option>
			<option value="7">7</option>
			<option value="8">8</option>
			<option value="9">9</option>
			<option value="10">10</option>
	</select></td>
</tr>
<tr><td>상호명</td>
	<td ><input type="text" id="pname" class="w3-input" name="pname" value=""></td></tr>
<tr><td>주소</td>
	<td><input type="text" id="paddress" class="w3-input" name="paddress" value=""></td></tr>
<tr><td>전화번호</td>
	<td><input type="text" id="phone" class="w3-input" name="phone" value=""></td></tr>
<tr><td>위도</td>
	<td><input type="text" id="map_a" class="w3-input" name="map_a" value=""></td></tr>
<tr><td>경도</td>
	<td><input type="text" id="map_b" class="w3-input" name="map_b" value=""></td></tr>
<tr><td colspan="2">
<!-- kakao API -->
<div class="map_wrap">
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>

    <div id="menu_wrap" class="bg_white">
        <div class="option">
            <div>
                    키워드 : <input type="text" value="서울역" id="keyword" size="15"> 
            <button onclick="searchPlaces(); return false;">검색하기</button> 
            </div>
        </div>
        <hr>
        <ul id="placesList"></ul>
        <div id="pagination"></div>
    </div>
	</div>
	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a8a1d695aec14a0b043d964924483a5&libraries=services"></script>
	<script>
// 마커를 담을 배열입니다
var markers = [];

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();  

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});

// 키워드로 장소를 검색합니다
searchPlaces();

// 키워드 검색을 요청하는 함수입니다
function searchPlaces() {

    var keyword = document.getElementById('keyword').value;

    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        alert('키워드를 입력해주세요!');
        return false;
    }

    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch( keyword, placesSearchCB); 
}

// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        displayPlaces(data);

        // 페이지 번호를 표출합니다
        displayPagination(pagination);

    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

        alert('검색 결과가 존재하지 않습니다.');
        return;

    } else if (status === kakao.maps.services.Status.ERROR) {

        alert('검색 결과 중 오류가 발생했습니다.');
        return;

    }
}

// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places) {

    var listEl = document.getElementById('placesList'), 
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(), 
    bounds = new kakao.maps.LatLngBounds(), 
    listStr = '';
    
    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);

    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();
    
    for ( var i=0; i<places.length; i++ ) {

        // 마커를 생성하고 지도에 표시합니다
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i), 
            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);

        // 마커와 검색결과 항목에 mouseover 했을때
        // 해당 장소에 인포윈도우에 장소명을 표시합니다
        // mouseout 했을 때는 인포윈도우를 닫습니다
        (function(marker, pname, praddress, paddress, phone, map_a, map_b) {
            kakao.maps.event.addListener(marker, 'mouseover', function() {
                displayInfowindow(marker, pname);
            });

            kakao.maps.event.addListener(map, 'mouseout', function() {
                infowindow.close();
            });
            
            // 리스트의 아이템을 클릭하면 정보들을 hidden 영역으로 전송
            itemEl.onclick = function() {
            	document.getElementById('pname').value = pname;            	
                if (praddress) {
                	document.getElementById('paddress').value = praddress;
                } else {
                	document.getElementById('paddress').value = paddress; 
                }
                document.getElementById('phone').value = phone;
            	document.getElementById('map_a').value = map_a;
            	document.getElementById('map_b').value = map_b;
            };

            itemEl.onmouseover =  function () {
                displayInfowindow(marker, pname);
            };

            itemEl.onmouseout =  function () {
                infowindow.close();
            };
        })(marker, places[i].place_name, places[i].road_address_name, places[i].address_name, places[i].phone  ,places[i].y, places[i].x);

        fragment.appendChild(itemEl);
    }

    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
}

// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {

    var el = document.createElement('li'),
    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info" style="cursor:pointer;">' +
                '   <h5>' + places.place_name + '</h5>';

    if (places.road_address_name) {
        itemStr += '    <span>' + places.road_address_name + '</span>' +
                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
    } else {
        itemStr += '    <span>' +  places.address_name  + '</span>'; 
    }
      itemStr += '  <span class="tel">' + places.phone + '</span>'; +
                '</div>';           

    el.innerHTML = itemStr;
    el.className = 'item';

    return el;
}


// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
        imgOptions =  {
            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage 
        });

    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

    return marker;
}

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}

// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(marker, title) {
    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

    infowindow.setContent(content);
    infowindow.open(map, marker);
}

 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}
</script>
</td></tr>
<tr><td colspan="2" align="center">
	<input type="submit" value="등록" class="w3-input" >
	<input type="reset" value="초기화" class="w3-input" ></td>
	</tr></table></form:form></body></html>